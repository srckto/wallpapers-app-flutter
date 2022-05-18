import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/account_controller.dart';
import 'package:wally_app/controllers/exploar_controller.dart';
import 'package:wally_app/controllers/favorite_controller.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/screens/wally_layout.dart';

class LoginController extends GetxController {
  bool isLoading = false;

  Future login({required String email, required String password}) async {
    try {
      isLoading = true;
      update();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserController.getUserData();

      isLoading = false;
      update();

      Get.find<AccountController>().onInit();
      Get.find<FavoriteController>().onInit();
      Get.find<ExploarController>().onInit();
      Get.off(() => WallyLayout());
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();

      Get.snackbar(
        "Error",
        e.message!,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(15),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
