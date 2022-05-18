import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool isLoading = false;

  void pickedImage() async {
    XFile? imagePicked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
    }
    update();
  }

  void uploadImage() async {
    try {
      isLoading = true;
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
        imageName: Uri.file(image!.path).pathSegments.last,
      );

      // upload _imageModel to FirebaseFirestore
      await _firestore.collection("images").add(_imageModel.toMap()).then((value) {
        value.update({"imageId": value.id});
      });


      isLoading = false;
      update();

      Get.back();
    } catch (error) {
      print(error);

      isLoading = false;
      update();
    }
  }
}
