import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oumayma/constants/app_colors.dart';
import 'package:oumayma/constants/app_images.dart';
import 'package:oumayma/helpers/shared_prefs.dart';
import 'package:oumayma/screens/authentication/login_Screen.dart';
import 'package:oumayma/widget/show_snack_bar.dart';

import '../screens/Map Mrigla/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile Details')),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<User>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final user = snapshot.data;
                  return buildProfileScreen(user);
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                SharedPreferencesHelper.clearAll();

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                ShowSnackBar.showSnackBar(text: "Logout Successfully");
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileScreen(User? user) {
    // Build your profile screen UI using the user data
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.white,
              backgroundImage: AssetImage(AppImages.user),
            ),
          ),
        ),
        const SizedBox(height: 10),
        user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${user.name}'),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}'),
                  const SizedBox(height: 8),
                  Text('Location: ${user.location}'),
                  const SizedBox(height: 8),
                  Text('Phone Number: ${user.phone_number}'),
                ],
              )
            : const Text('No user data'),
      ],
    );
  }

  Future<User> fetchUserProfile() async {
    String url = "http://10.0.2.2:8000/api/auth/profile";

    String? token = await SharedPreferencesHelper.getString('token');

    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var user = User.fromJson(jsonData['user']);
      return user;
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
