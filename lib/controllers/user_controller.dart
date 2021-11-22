import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wally_app/models/user_model.dart';

class UserController {
  static late UserModel userModel;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future getUserData() async {
    if (_auth.currentUser != null) {
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data()!);
        print(userModel);
        print(userModel.email);
        print(userModel.name);
      });
    }
  }
}
