import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/login_controller.dart';
import 'package:wally_app/screens/register_screen.dart';

import '../config.dart';

class LogInScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage("assets/bg.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 100,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage("assets/logo_circle.png"),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.4),
                        filled: true,
                        prefixIcon: Icon(Icons.email_outlined),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Email Address"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your email";
                        } else
                          return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.4),
                        prefixIcon: Icon(Icons.lock_outline),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("password"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Pawword is too short";
                        } else
                          return null;
                      },
                    ),
                  ),
                  GetBuilder<LoginController>(
                    builder: (_) {
                      return _loginController.state
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CircularProgressIndicator(
                                color: k_secondaryColor,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: InkWell(
                                  onTap: () {
                                     _loginController.login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [k_primaryColor, k_secondaryColor],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      "LogIn",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Don't Have Any Account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.off(() => RegisterScreen()),
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
