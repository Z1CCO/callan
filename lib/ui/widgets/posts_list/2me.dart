import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_fire/ui/screens/homescreen.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/domain/entity/user.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UploadImage extends StatefulWidget {
  final User? currentUser;
  const UploadImage({super.key, required this.currentUser});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? imageFile;
  final _locationController = TextEditingController();
  final _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;
  bool icLoading = false;
  String postId = const Uuid().v4();

  void handleTakePhoto(BuildContext context) async {
    Navigator.pop(context);
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 900,
      imageQuality: 80,
    );
    if (file != null) setState(() => imageFile = File(file.path));
  }

  void handleChooseFromGallery(BuildContext context) async {
    Navigator.pop(context);
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 675,
      maxWidth: 900,
    );
    if (file != null) setState(() => imageFile = File(file.path));
  }

  selectImage(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text('Rasm yuklash'),
        children: [
          SimpleDialogOption(
            child: const Text('Galereya'),
            onPressed: () => handleChooseFromGallery(context),
          ),
          SimpleDialogOption(
            child: const Text('Camera'),
            onPressed: () => handleTakePhoto(context),
          ),
          SimpleDialogOption(
            child: const Text('Chiqish'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void clearImage() => setState(() => imageFile = null);

  void getUserLocation() async {
    setState(() => icLoading = true);
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    final placemark = placemarks.first;
    final formatedAdress = '${placemark.locality},${placemark.country}';
    _locationController.text = formatedAdress;
    icLoading = false;
    setState(() {});
  }

  Future<void> compressImage() async {
    final file = await imageFile!.readAsBytes();
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final decodedImage = img.decodeImage(file);
    final compressedImaga = File("$path/image$postId.jpg")
      ..writeAsBytesSync(
        img.encodeJpg(decodedImage!, quality: 85),
      );
    setState(() => imageFile = compressedImaga);
  }

  Future<String> uploadImage(imageFile) async {
    UploadTask uploadTask =
        storageRef.child("post.$postId.jpg").putFile(imageFile);
    String downloadUrl = await (await uploadTask).ref.getDownloadURL();

    return downloadUrl;
  }

  void handleSubmit() async {
    setState(() => isUploading = true);
    await compressImage();
    String mediaUrl = await uploadImage(imageFile);

    createPostInFirestore(
        mediaUrl: mediaUrl,
        location: _locationController.text,
        description: _captionController.text);
    _locationController.clear();
    _captionController.clear();
    imageFile = null;
    isUploading = false;
    postId = const Uuid().v4();
    setState(() {});
  }

  createPostInFirestore({
    required String mediaUrl,
    required String location,
    required String description,
  }) {
    postDB.doc(currentUser!.id).collection('userPosts').doc(postId).set({
      'postId': postId,
      'ownerId': currentUser!.id,
      'username': currentUser!.username,
      'description': description,
      'location': location,
      'mediaUrl': mediaUrl,
      'timestamp': DateTime.now(),
      'likes': {},
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return imageFile == null
        ? UploadGetImage(onPressed: () => selectImage(context))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Rasm yuklash',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: isUploading ? null : () => handleSubmit(),
                  child: const Text(
                    'Yuklash',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ],
              shadowColor: Colors.grey,
              elevation: 1,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (isUploading) const LinearProgressIndicator(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    height: 220.0,
                    width: double.infinity,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            image: DecorationImage(
                              image: FileImage(
                                File(imageFile!.path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(currentUser!.photoUrl),
                    ),
                    title: SizedBox(
                      width: 250.0,
                      child: TextField(
                        controller: _captionController,
                        decoration: const InputDecoration(
                          hintText: "Nomlash",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.pin_drop,
                      color: Colors.blue,
                      size: 38.0,
                    ),
                    title: SizedBox(
                      width: 250.0,
                      child: TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          hintText: "Joylashuv",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55.0,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.blue),
                        ),
                        onPressed: getUserLocation,
                        icon: icLoading
                            ? const Text('')
                            : const Icon(
                                Icons.my_location,
                                size: 30.0,
                                color: Colors.white,
                              ),
                        label: icLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Hozirgi Joylashuv',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

// ignore: must_be_immutable
class UploadGetImage extends StatelessWidget {
  VoidCallback onPressed;
  UploadGetImage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 350.0,
              child: Image(
                image: AssetImage('assets/images/upload.jpg'),
              ),
            ),
            const SizedBox(
              height: 30.0,
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
