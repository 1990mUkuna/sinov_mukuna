import 'package:flutter/material.dart';
import 'Authentication/anonymous_login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = const Duration(seconds: 1);
    // Delayed 3 second to do something
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        //return TestWidget();
        //return RoootBottomNavigation();
        return const WelcomePage();
      }), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: screenHeight * 0.35,
              ),
              Image.asset(
                "assets/images/spotify-logo.png",
                height: screenHeight * 0.30,
                width: screenwidth * 15,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
