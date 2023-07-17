import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:untitled12/views/HomePage.dart';

import 'loginPage.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splashIconSize: 200,
//       centered: true,
//       backgroundColor: CupertinoColors.systemBlue,
//       splash: 'assets/images/logo.png',
//       splashTransition: SplashTransition.fadeTransition,
//       animationDuration: const Duration(seconds: 5),
//       nextScreen: RegisterPage(),
//     );
//   }

//   _checkLogin() async {
//     Future.delayed(const Duration(milliseconds: 2000), () async {
//       bool exists =
//           await const FlutterSecureStorage().containsKey(key: "token");
//       Future.delayed(const Duration(seconds: 10), () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => exists ? const HomePage() : RegisterPage(),
//           ),
//         );
//       });
//     });
//   }
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 200,
      centered: true,
      backgroundColor: CupertinoColors.systemBlue,
      splash: 'assets/images/logo.png',
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 5),
      nextScreen: RegisterPage(),
    );
  }

  _checkLogin() async {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      bool exists =
          await const FlutterSecureStorage().containsKey(key: "token");
      Future.delayed(const Duration(seconds: 10), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => exists ? const HomePage() : RegisterPage(),
          ),
        );
      });
    });
  }
}
