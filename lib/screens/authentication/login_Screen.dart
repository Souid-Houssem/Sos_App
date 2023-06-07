import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oumayma/constants/app_colors.dart';
import 'package:oumayma/constants/app_strings.dart';
import 'package:oumayma/helpers/shared_prefs.dart';
import 'package:oumayma/screens/authentication/signup_screen.dart';
import 'package:oumayma/screens/on_board/on_board_screen.dart';
import 'package:oumayma/widget/button_widget.dart';
import 'package:oumayma/widget/show_snack_bar.dart';
import 'package:oumayma/widget/textfield_widget.dart';

import '../bottom_navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    bool isPasswordVisible = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      var jsonResponse;

      var data = {
        "email": emailController.text,
        "password": passController.text
      };
      var bodyy = json.encode(data);

      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/auth/login"),
        body: bodyy,
        headers: {"Content-Type": "application/json"},
      );
      String dataa = response.body;
      var jsondataa = json.decode(dataa);
      print(jsondataa);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("success");
        await SharedPreferencesHelper.setString('token', jsondataa['token']);

        String? token = await SharedPreferencesHelper.getString('token');
        print(token);
        ShowSnackBar.showSnackBar(text: "Login Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBarScreen(),
          ),
        );
      } else {
        ShowSnackBar.showSnackBar(text: "Login Failed");
      }
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset("assets/images/container.png",
              height: MediaQuery.of(context).size.height / 5),
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                      const Text(
                        "Log in to your account",
                        style: TextStyle(color: AppColors.grey),
                      ),
                      const SizedBox(height: 30),
                      TextFieldWidget(
                        controller: emailController,
                        hintText: "Email ",
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (email) {
                          if (email!.trim().isEmpty) {
                            ShowSnackBar.errorSnackBar(
                                text: "Email ID required");
                            return "Email ID required";
                          } else if (!email.trim().isValidEmail()) {
                            ShowSnackBar.errorSnackBar(
                                text: "Invalid Email ID");
                            return "Invalid Email ID";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                   TextFieldWidget(
    controller: passController,
    hintText: "Password",
    obscureText: !isPasswordVisible, // this will obscure or reveal the text based on the isPasswordVisible flag
    prefixIcon: const Icon(Icons.lock_outline),
    suffixIcon: Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 53,
          right: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
        child: Text(
          isPasswordVisible ? "HIDE" : "SHOW", // this will display "SHOW" or "HIDE" based on the isPasswordVisible flag
          style: TextStyle(
              fontSize: 10.7,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
    validator: (pass) {
      // ...
    },
  ),
  // ...
                      const SizedBox(height: 50),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: ButtonWidget(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                text: "LOGIN"),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Don't have an account? "),
                    InkWell(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen())),
                        child: Text("Sign up",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
