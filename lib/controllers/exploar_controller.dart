import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wally_app/models/image_model.dart';

class ExploarController extends GetxController {
  List<ImageModel> images = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  onInit() async {
    super.onInit();
    images = [];
    update();
    await getImages();
    update();
  }

  Future getImages() async {
    // get all images form firebase
    try {
      await _firestore.collection("images").orderBy("date").get().then((value) {
        images = [];
        value.docs.forEach((element) {
          images.add(ImageModel.fromJson(element.data()));
        });
        update();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
