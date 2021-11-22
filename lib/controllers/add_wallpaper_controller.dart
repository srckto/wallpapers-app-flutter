import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/models/image_model.dart';

class AddWallpaperController extends GetxController {
  File? image;
  String? imageUrl;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  bool state = false;

  void pickedImage() async {
    // picked image from gallery
    // Then, initialize this to a variable (image) if (picked image) is not equal to null
    XFile? imagePicked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
    }
    update();
  }

  void uploadImage() async {
    try {
      // the variable state is a flag to show linear progress indicator or hidden it
      // if true => show LinearProgressIndicator
      // else false => hide LinearProgressIndicator
      state = true;
      update();

      // upload to firestorage
      TaskSnapshot path = await _storage
          .ref()
          .child("users/${Uri.file(image!.path).pathSegments.last}")
          .putFile(image!);

      // get the image URL of the uploaded image
      imageUrl = await path.ref.getDownloadURL();

      // Create instance form ImageModel
      ImageModel _imageModel = ImageModel(
        imageUrl: imageUrl!,
        date: DateTime.now().toString(),
        uploaded_by: UserController.userModel.uId,
        favorites: {},
      );

      // upload _imageModel to FirebaseFirestore
      await _firestore.collection("images").add(_imageModel.toMap()).then((value) {
        value.update({"imageId": value.id});
      });

      // Change state to false to hide a LinearProgressIndicator
      state = false;
      update();

      Get.back();
    } catch (error) {
      print(error);
      // if when happen an error alse change state to hide the LinearProgressIndicator
      state = false;
      update();
    }
  }
}
