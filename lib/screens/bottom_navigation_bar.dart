import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oumayma/constants/app_colors.dart';
import 'package:oumayma/Profile/profile.dart';
import 'package:oumayma/screens/ADEM_APP/Call.dart';

import 'package:permission_handler/permission_handler.dart';

import 'ADEM_APP/livesafe.dart';
import 'Map Mrigla/Map.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    requestLocationPermission(); // Request location permission when the screen is initialized
  }

  List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.emergency),
      label: 'SOS',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.call),
      label: 'Call',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: 'Profile',
    ),
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    const Mapp(),
    const LiveSafe(),
    const HelplineNumbers(),
    const Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.primary,
        ),
        child: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: AppColors.primary,
          unselectedItemColor: AppColors.white54,
          iconSize: 30,
          selectedLabelStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, do something
      print('Location permission granted');
    } else if (status.isDenied) {
      // Permission denied, show an error message or request again
      print('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      print('Location permission permanently denied');
      openAppSettings();
    }
  }
}
