import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/authenticated.dart';
import 'package:flutter_firebase_fire/ui/screens/create_user.dart';
import 'package:flutter_firebase_fire/ui/widgets/unauthenticated.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
final userDB = FirebaseFirestore.instance.collection('users');
final postDB = FirebaseFirestore.instance.collection('posts');
final storageRef = FirebaseStorage.instance.ref();
final commentDB = FirebaseFirestore.instance.collection('comments');
final activityDB = FirebaseFirestore.instance.collection('feed');
final followersDB = FirebaseFirestore.instance.collection('followers');
final followingDB = FirebaseFirestore.instance.collection('following');
final groupDB = FirebaseFirestore.instance.collection('group');

User? currentUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAuthenticated = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      checkAndRegister(account);
    }, onError: (e) {
      debugPrint('error: $e');
    });
    googleSignIn.signInSilently(suppressErrors: false).then(
      (account) => checkAndRegister(account),
      onError: (e) {
        debugPrint('error: $e');
      },
    );
  }

  void login() => googleSignIn.signIn();

  void signOut() => googleSignIn.signOut();

  void checkAndRegister(GoogleSignInAccount? account) {
    if (account != null) {
      createUserFirestore();
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }
    setState(() {});
  }

  void createUserFirestore() async {
    final GoogleSignInAccount? user = googleSignIn.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await userDB.doc(user.id).get();
      if (!doc.exists) {
        // ignore: use_build_context_synchronously
        final username = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contaxt) => CreateUser(
              user: user.id,
            ),
          ),
        );

        if (username != null) {
          userDB.doc(user.id).set(
            {
              'id': user.id,
              'username': username,
              'photoUrl': user.photoUrl,
              'email': user.email,
              'displayName': user.displayName,
              'bio': '',
              'score': 5,
              'tolov': 'To\'langan',
              'admin': false,
            },
          );
          doc = await userDB.doc(user.id).get();
        }
      }
      currentUser = User.fromDocument(doc);
      if (mounted) setState(() {});
    }
  }

  void cupertinoOnTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated && currentUser != null) {
      return Authenticated(currentIndex: _currentIndex, onTap: cupertinoOnTap);
    }
    return unAuthenticated(onTap: login);
  }
}
