import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/models/image_model.dart';

class FavoriteController extends GetxController {
  List<ImageModel> images = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  // ignore: must_call_super
  onInit() async {
    await getFavoriteImages();
    update();
  }

  Future<void> getFavoriteImages() async {
    // Get all favorte images from farebaseFirestore
    // path */images/*all doces

    return _firestore.collection("images").orderBy("date").get().then((value) {
      images = [];
      value.docs.forEach((element) {
        // if Map of favorites contain uid and favorites of key(uid) equal true
        if ((element["favorites"].containsKey(UserController.userModel.uId)) &&
            (element["favorites"]["${UserController.userModel.uId}"] == true)) {
          images.add(ImageModel.fromJson(element.data()));
        }
      });
      update();
    });
  }
}
