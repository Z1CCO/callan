import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentUserId;
  const EditProfileScreen({super.key, required this.currentUserId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  String? _displayErrorText;
  String? _bioErrorText;
  bool isLoading = false;
  late User _user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    setState(() => isLoading = true);

    final doc = await userDB.doc(widget.currentUserId).get();
    _user = User.fromDocument(doc);
    _displayNameController.text = _user.username;
    _bioController.text = _user.boi;

    setState(() => isLoading = false);
  }

  // ignore: non_constant_identifier_names
  void UpdateProfile() {
    _displayErrorText = null;
    _bioErrorText = null;
    final String displayName = _displayNameController.text.trim();
    if (displayName.length < 3 || displayName.isEmpty) {
      _displayErrorText = 'Ko\'rsatilgan nom qisqa';
    }

    setState(() {});
    if (_displayErrorText == null && _bioErrorText == null) {
      userDB.doc(widget.currentUserId).update(
        {
          'username': displayName,
        },
      );
      Navigator.pop(context, true);
    }
  }

  void showLogoutDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Ishonchingiz komilmi?'),
        content: const Text('Profildan chiqishga ishonchingiz komilmi?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Yo\'q'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            onPressed: logOut,
            child: const Text('Ha'),
          ),
        ],
      ),
    );
  }

  void logOut() async {
    await googleSignIn.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Profilni tahrirlash',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: showLogoutDialog,
            color: Colors.red,
            iconSize: 28.0,
            splashRadius: 20.0,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              CachedNetworkImageProvider(_user.photoUrl),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _displayNameController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Ism',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: _displayErrorText),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton(
              onPressed: UpdateProfile,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
    );
  }
}


// class DropDownWidget extends StatefulWidget {
//  const  DropDownWidget({super.key});

//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState();
// }

// class _DropDownWidgetState extends State<DropDownWidget> {

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
