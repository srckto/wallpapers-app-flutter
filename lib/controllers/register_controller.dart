import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/account_controller.dart';
import 'package:wally_app/controllers/exploar_controller.dart';
import 'package:wally_app/controllers/favorite_controller.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/models/user_model.dart';
import 'package:wally_app/screens/wally_layout.dart';

class RegisterController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool state = false;

  void register({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      state = true;
      update();

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel model = UserModel(
        email: email,
        name: name,
        uId: userCredential.user!.uid,
        image:
            "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
        cover: "https://image.freepik.com/free-photo/friends-social-media_53876-90180.jpg",
      );

      await _db.collection('users').doc(userCredential.user!.uid).set(model.toMap()).then((value) {
        state = false;
        update();
      });

      await UserController.getUserData();

      Get.find<AccountController>().onInit();
      Get.find<FavoriteController>().onInit();
      Get.find<ExploarController>().onInit();
      Get.off(() => WallyLayout());
    } on FirebaseAuthException catch (e) {
      state = false;
      update();

      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Error"),
            content: Text("${e.message}"),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
