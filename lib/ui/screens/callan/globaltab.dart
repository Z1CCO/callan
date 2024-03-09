import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';

class GlobalTab extends StatefulWidget {
  const GlobalTab({
    super.key,
  });

  @override
  State<GlobalTab> createState() => _GlobalTabState();
}

class _GlobalTabState extends State<GlobalTab> {
  late final Future? _future;
  final currentRank = currentUser?.score;

  @override
  void initState() {
    _future = getActivityuser();
    super.initState();
  }

  Future getActivityuser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('score', descending: true)
        .limit(10)
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              highScore.add(element.reference.id);
            },
          ),
        );
  }

  List<String> highScore = [];
  List top10 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Top Users',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: highScore.length,
                    itemBuilder: (context, index) => GlobalTabItemWidget(
                      docID: highScore[index],
                      rank: currentRank!.toString(),
                      reating: top10[index],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GlobalTabItemWidget extends StatefulWidget {
  final String rank;
  final String reating;
  final String docID;

  const GlobalTabItemWidget(
      {super.key,
      required this.rank,
      required this.reating,
      required this.docID});

  @override
  State<GlobalTabItemWidget> createState() => _GlobalTabItemWidgetState();
}

class _GlobalTabItemWidgetState extends State<GlobalTabItemWidget> {
  int top = 0;
  void orin(int index) {
    top = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userDB.doc(widget.docID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(data['photoUrl']),
                  ),
                  title: GestureDetector(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                        children: [
                          TextSpan(
                            text: data['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        data['score'].toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'coin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 20.0,
                    height: 30.0,
                    child: Center(
                      child: Text(
                        widget.reating,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 0,
                color: Colors.white,
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
