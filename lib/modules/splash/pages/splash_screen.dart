import 'package:animate_do/animate_do.dart';
import 'package:evently/core/ids/app_ids.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  final String idName = AppIds.splashScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ZoomIn(
                  duration: Duration(seconds: 1),
                  child: Hero(
                    tag: 'logo',

                    child: Center(
                      child: Image.asset('assets/logos/logo Evently.png'),
                    ),
                  ),
                ),
              ),
              FadeInUp(
                onFinish: (direction) {
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppIds.onBoardingScreen,
                    );
                    // Navigator.pushReplacementNamed(
                    //   context,
                    //   AppIds.onBoardingScreen,
                    // );
                    // if (FirebaseAuth.instance.currentUser != null) {
                    //   Navigator.pushReplacementNamed(
                    //     context,
                    //     AppIds.layoutScreen,
                    //   );
                    // } else {
                    //   Navigator.pushReplacementNamed(
                    //     context,
                    //     AppIds.onBoardingScreen,
                    //   );
                    // }
                  });
                },
                delay: Duration(seconds: 1),

                child: Center(child: Image.asset('assets/logos/Logo.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
