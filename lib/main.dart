import 'package:flutter/material.dart';
import 'package:oumayma/constants/app_strings.dart';
import 'package:oumayma/constants/global_context.dart';
import 'package:oumayma/screens/authentication/login_Screen.dart';
import 'package:oumayma/screens/on_board/on_board_screen.dart';
import 'package:oumayma/widget/show_snack_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: ShowSnackBar.messengerKey,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: "Vollkorn"),
        home: const OnBoardScreen());
        
  }
}
