import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/models/image_model.dart';

class WallpaperViewController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  bool isFavorite = false;

  void getIsFavorite(ImageModel imageModel) {
    isFavorite = imageModel.favorites[UserController.userModel.uId] ?? false;
    update();
  }

  Future addToFavoriteOrDelete({required ImageModel imageModel}) async {
    // print(imageModel.favorites.containsKey(UserController.userModel.uId));
    // print(UserController.userModel.uId);

    isFavorite = imageModel.favorites[UserController.userModel.uId] ?? false;
    update();

    if (imageModel.favorites.containsKey(UserController.userModel.uId)) {
      bool? _isFavorite = imageModel.favorites[UserController.userModel.uId]!;
      if (_isFavorite!) {
        await _fireStore.collection("images").doc(imageModel.imageId).update({
          "favorites.${UserController.userModel.uId}": false,
        }).then((value) {
          imageModel.favorites[UserController.userModel.uId] = false;
          isFavorite = false;
        }).catchError((error) {
          print(error.toString());
        });
        update();
      } else {
        await _fireStore.collection("images").doc(imageModel.imageId).update({
          "favorites.${UserController.userModel.uId}": true,
        }).then((value) {
          imageModel.favorites[UserController.userModel.uId] = true;
          isFavorite = true;
        }).catchError((error) {
          print(error.toString());
        });
        update();
      }
    } else {
      await _fireStore.collection("images").doc(imageModel.imageId).update({
        "favorites.${UserController.userModel.uId}": true,
      }).then((value) {
        imageModel.favorites[UserController.userModel.uId] = true;
        isFavorite = true;
      }).catchError((error) {
        print(error.toString());
      });
      update();
    }
  }

  void launchURL(String url) async {
    try {
      await launch(url, enableJavaScript: true);
    } catch (e) {
      print(e.toString());
    }
  }

  void createDynamicLink({required ImageModel imageModel}) async {
    DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      link: Uri.parse(imageModel.imageId!),
      uriPrefix: 'https://wallyappc.page.link',
      androidParameters: AndroidParameters(
        packageName: "com.example.wally_app",
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: "com.example.wally_app",
        minimumVersion: "0",
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Wally App",
        imageUrl: Uri.parse(imageModel.imageUrl),
      ),
    );

    Uri url = await dynamicLinkParameters.buildUrl();
    // print(url.toString());

    Share.share(url.toString());
  }
}
