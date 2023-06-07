import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oumayma/constants/app_colors.dart';
import 'package:oumayma/constants/app_images.dart';
import 'package:oumayma/widget/button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboarding_model.dart';
import '../authentication/login_Screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  List<OnBoardingModel> list = [];

  addData() {
    list.add(OnBoardingModel(
        title: "Get your live position",
        subTitle:
            "Get your current position.",
        image: AppImages.transactionFaster));
    list.add(OnBoardingModel(
        title: "Search nereast police station",
        subTitle:
            "You can easily see the nearest police station",
        image: AppImages.buySellCoin));
    list.add(OnBoardingModel(
        title: "SoS",
        subTitle: "Emergency phone calls ",
        image: AppImages.digitalLive));
  }

  int selectedIndex = 0;
  final controller = PageController(keepPage: true);
  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary50,
      appBar: AppBar(
        backgroundColor: AppColors.primary50,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 2.0),
            child: GestureDetector(
              onTap: () {
                controller.animateToPage(2,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInSine);
              },
              child: Text(
                selectedIndex == 2 ? "" : "SKIP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
          itemCount: list.length,
          controller: controller,
          onPageChanged: (i) {
            setState(() {
              selectedIndex = i;
            });
          },
          itemBuilder: (context, i) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  list[i].image,
                  width: size.width / 2,
                  height: size.height / 3,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width / 1.5,
                  child: Text(list[i].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 25,
                          letterSpacing: 1)),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width / 1.7,
                  child: Text(
                    list[i].subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmoothPageIndicator(
                controller: controller,
                count: list.length,
                effect: const JumpingDotEffect(
                    verticalOffset: 16.0, dotHeight: 13, dotWidth: 13)),
            ButtonWidget(
                onPressed: () {
                  if (selectedIndex == 2) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  } else {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInSine);
                  }
                },
                text: selectedIndex == 2 ? "Get Started" : "Next")
          ],
        ),
      ),
    );
  }
}
