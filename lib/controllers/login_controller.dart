import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/screens/wally_layout.dart';

class LoginController extends GetxController {
  bool state = false;

  Future login({required String email, required String password}) async {
    try {
      // Change state to show a CircualrProgressIndicator
      state = true;
      update();

      // Sign In an account in FirebaseAuth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Use a UserController class to save user data and use this data in all app
      await UserController.getUserData();

      // Change state to hide a CircualrProgressIndicator
      state = false;
      update();

      // Navigate to HomeScreen of app
      Get.off(() => WallyLayout());
    } on FirebaseAuthException catch (e) {
      // Change state to hide a CircualrProgressIndicator
      state = false;
      update();

      // Show the error in the screen to the user if found.
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
