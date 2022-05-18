import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/models/image_model.dart';

class AccountController extends GetxController {
  List<ImageModel> images = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Reference _storage = FirebaseStorage.instance.ref();

  @override
  onInit() async {
    super.onInit();
    images = [];
    update();
    await getImagesOfUser();
    update();
  }

  Future<void> getImagesOfUser() async {
    await _firestore.collection("images").orderBy("date").get().then((value) {
      images = [];
      value.docs.forEach((element) {
        if (UserController.userModel.uId == element["uploaded_by"]) {
          images.add(ImageModel.fromJson(element.data()));
        }
      });
    });
    update();
  }

  Future<void> deleteImage(ImageModel imageModel) async {
    images.remove(imageModel);
    update();
    await _firestore.collection("images").doc(imageModel.imageId).delete();
    await _storage.child("users/${imageModel.imageName}").delete();
  }
}
