import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/register_controller.dart';
import 'package:wally_app/screens/login_screen.dart';

import '../config.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final RegisterController _registerController = Get.put(RegisterController());

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
                          child: Text("Your Name"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
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
                    ),
                  ),
                  GetBuilder<RegisterController>(
                    builder: (_) {
                      return _registerController.state
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
                                      _registerController.register(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        name: _nameController.text,
                                        context: context,
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
                                        "Register",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )),
                            );
                    },
                  ),

                  SizedBox(height: 10),
                  Text(
                    " -  OR  - ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  // SizedBox(height: 5),
                  TextButton(
                    onPressed: () => Get.off(() => LogInScreen()),
                    child: Text(
                      "LogIn",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
