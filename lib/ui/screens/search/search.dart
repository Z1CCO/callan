import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:flutter_firebase_fire/ui/widgets/user_result.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot>? _searchResultFuture;
  void handleSearch(String query) async {
    if (query.isEmpty) return;
    String queryFirstLatter = query[0];
    query = query.replaceFirst(
      queryFirstLatter,
      queryFirstLatter.toUpperCase(),
    );
    // ignore: no_leading_underscores_for_local_identifiers
    Future<QuerySnapshot> _users =
        userDB.where('displayName', isGreaterThanOrEqualTo: query).get();

    _searchResultFuture = _users;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchScreenAppBarWidget(
        onSubmit: handleSearch,
      ),
      body: _searchResultFuture == null
          ? const NoContentWidget()
          : SearchBodyWidget(
              searchResultFuture: _searchResultFuture!,
            ),
    );
  }
}

class SearchBodyWidget extends StatelessWidget {
  final Future<QuerySnapshot> searchResultFuture;
  const SearchBodyWidget({super.key, required this.searchResultFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchResultFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data.docs;
        final users = <User>[];
        for (var doc in docs) {
          users.add(User.fromDocument(doc));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return UserResultWidget(
              user: user,
            );
          },
        );
      },
    );
  }
}

class NoContentWidget extends StatelessWidget {
  const NoContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 550.0,
              height: 550.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/callan.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreenAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final ValueChanged<String>? onSubmit;
  const SearchScreenAppBarWidget({Key? key, required this.onSubmit})
      : super(key: key);

  @override
  State<SearchScreenAppBarWidget> createState() =>
      _SearchScreenAppBarWidgetState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchScreenAppBarWidgetState extends State<SearchScreenAppBarWidget> {
  final _controller = TextEditingController();

  void clearTextField() {
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(
            bottom: 8.0, top: 25.0, left: 10.0, right: 10.0),
        child: TextFormField(
          onFieldSubmitted: widget.onSubmit,
          controller: _controller,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              size: 28,
            ),
            suffix: IconButton(
              splashRadius: 15,
              onPressed: clearTextField,
              icon: const Icon(Icons.close),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
