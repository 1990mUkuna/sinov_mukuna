import 'package:flutter/material.dart';

const backGroundColor = Colors.white;
const primaryButtonColor = Color.fromRGBO(31, 169, 3, 1);
const primaryColor = Colors.black;
const secondaryColor = Colors.grey;
const darkGreyColor = Color.fromRGBO(97, 97, 97, 1);

Widget sizeVer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}

class PageConst {
  static const String profilePage = "profilePage";
  static const String pinsPage = "pinsPage";
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
  static const String onboarding = "onboarding";
  static const String homeScreen = "homeScreen";
}
