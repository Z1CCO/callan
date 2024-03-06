import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UploadGetImage extends StatelessWidget {
  VoidCallback onPressed;
  UploadGetImage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            const SizedBox(
              width: double.infinity,
              height: 450.0,
              child: Image(
                image: AssetImage('assets/images/upload.jpg'),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              onPressed: onPressed,
              icon: const Icon(
                Icons.file_upload_outlined,
                size: 30,
                color: Colors.white,
              ),
              label: const Text(
                'Rasm Yuklash',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
