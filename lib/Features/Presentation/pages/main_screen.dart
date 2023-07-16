import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinov8_tech_assignment/const.dart';

import 'home/home_page.dart';
import 'pins/pins_page.dart';
import 'profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: backGroundColor,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: backGroundColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: primaryColor), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add, color: primaryColor), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, color: primaryColor),
              label: ""),
        ],
        onTap: navigationTapped,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomePage(
          ),
           PinsPage(),
            ProfilePage()
        ],
      ),
    );
  }
}
