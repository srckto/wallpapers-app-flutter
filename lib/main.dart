import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wally_app/config.dart';
import 'package:wally_app/screens/wally_layout.dart';
import 'package:wally_app/screens/login_screen.dart';
import 'controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserController.getUserData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.cairo().fontFamily,
        colorScheme: ColorScheme.dark(
          primary: k_secondaryColor,
        ),
        brightness: Brightness.dark,
      ),
      home: FirebaseAuth.instance.currentUser == null ? LogInScreen() : WallyLayout(),
    );
  }
}
