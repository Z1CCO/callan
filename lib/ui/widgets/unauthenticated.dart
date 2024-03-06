import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class unAuthenticated extends StatelessWidget {
  final VoidCallback onTap;
  const unAuthenticated({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: snapshot.data == ConnectivityResult.none
              ? const Center(
                  child: Image(
                    image: AssetImage('assets/images/noiternet.jpg'),
                  ),
                )
              : Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue.shade400,
                          Colors.blue.shade600,
                          Colors.amber.shade600,
                          Colors.amber.shade800
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80.0,
                        ),
                        const SizedBox(
                          width: 220.0,
                          height: 220.0,
                          child: Image(
                            color: Colors.white,
                            image: AssetImage('assets/images/callan2.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'CALLAN',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'SingleDay',
                              color: Colors.white),
                        ),
                        const Text(
                          'EDUCATION',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'SingleDay',
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            height: 55,
                            width: 280,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/img.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
