import 'package:flutter/material.dart';
import 'package:oumayma/constants/app_strings.dart';
import 'package:oumayma/screens/authentication/login_Screen.dart';
import 'package:oumayma/widget/button_widget.dart';
import 'package:oumayma/widget/textfield_widget.dart';
import 'package:oumayma/widget/show_snack_bar.dart';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/shared_prefs.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isAccepted = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> register() async {
      String url = "http://10.0.2.2:8000/api/auth/register";

      var data = {
        "name": fullname.text,
        "email": email.text,
        "password": password.text,
        "phone_number": phone.text,
        "location": location.text,
      };
      var bodyy = json.encode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: bodyy, headers: {"Content-Type": "application/json"});
      String dataa = response.body;
      var jsondataa = json.decode(dataa);
      print(response.statusCode);
      print(jsondataa);
      if (response.statusCode == 200) {
        print("success");
        await SharedPreferencesHelper.setString('token', jsondataa['token']);

        String? token = await SharedPreferencesHelper.getString('token');
        print(token);
        ShowSnackBar.showSnackBar(text: "Registered Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        ShowSnackBar.errorSnackBar(text: "Error");
      }
    }

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/container.png",
            height: MediaQuery.of(context).size.height / 5,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 7,
              left: 28.0,
              right: 28.0,
              bottom: 28.0,
            ),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Join SOS App",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Text(
                        "Create your account",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      TextFieldWidget(
                        controller: fullname,
                        hintText: "Full name",
                        prefixIcon: const Icon(Icons.person_3_outlined),
                        validator: (fName) {
                          if (fName!.isEmpty) {
                            ShowSnackBar.errorSnackBar(
                                text: "Full name required");
                            return "Full name required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        controller: email,
                        hintText: "Email Id",
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
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        controller: password,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outlined),
                        obscureText: true,
                        validator: (pass) {
                          if (pass!.isEmpty) {
                            ShowSnackBar.errorSnackBar(
                                text: "Password required");
                            return "Password required";
                          } else if (pass.length < 6) {
                            ShowSnackBar.errorSnackBar(
                                text:
                                    "Password must be more than 6 characters");
                            return "Password required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        controller: location,
                        hintText: "Location",
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        validator: (location) {
                          if (location!.isEmpty) {
                            ShowSnackBar.errorSnackBar(
                                text: "Location required");
                            return "Location required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        controller: phone,
                        hintText: "Phone Number",
                        prefixIcon: const Icon(Icons.phone_outlined),
                        validator: (phoneNumber) {
                          if (phoneNumber!.isEmpty) {
                            ShowSnackBar.errorSnackBar(
                                text: "Phone number required");
                            return "Phone number required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAccepted = !isAccepted;
                              });
                            },
                            child: Icon(
                              isAccepted
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: isAccepted ? Colors.blue : Colors.black,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Flexible(
                            child: Text(
                              "I certify that I am 18 years or older and I agree to the Terms and Conditions and Privacy Policy",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 35),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: ButtonWidget(
                            onPressed: isAccepted
                                ? () {
                                    if (formKey.currentState!.validate()) {
                                      register();
                                    }
                                  }
                                : null,
                            text: "SIGN UP",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
