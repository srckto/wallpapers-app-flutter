import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/models/image_model.dart';

class AccountController extends GetxController {
  List<ImageModel> images = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  // ignore: must_call_super
  onInit() async {
    await getImages();
    update();
  }

  Future getImages() async {
    // Get images from firebase
    // Only images that users uploaded
    // sorted by dateTime
    // when completed it, fill the list of [images]
    // path in firebase /images/*addDocs
    return _firestore.collection("images").orderBy("date").get().then((value) {
      images = [];
      value.docs.forEach((element) {
        // [uploaded_by] uid of user who uploaed the image
        if (UserController.userModel.uId == element["uploaded_by"]) {
          images.add(ImageModel.fromJson(element.data()));
        }
      });
      update();
    });
  }

  Future deleteImage(ImageModel imageModel) async {
    images.remove(imageModel);
    update();
    await _firestore.collection("images").doc(imageModel.imageId).delete();
  }
}
