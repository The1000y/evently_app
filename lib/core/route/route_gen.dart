import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/route/get_helper.dart';
import 'package:evently/modules/auth/pages/forget_screen.dart';
import 'package:evently/modules/auth/pages/login.dart';
import 'package:evently/modules/auth/pages/register.dart';
import 'package:evently/modules/events/pages/add_event.dart';
import 'package:evently/modules/layout/pages/layout_screen.dart';
import 'package:evently/modules/on_boarding/pages/details_on_boarding_screen.dart';
import 'package:evently/modules/on_boarding/pages/on_boarding_Screen.dart';
import 'package:evently/modules/splash/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouteGen {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    print(settings.name);

    final bool onBoarding = GetHelper.prefs.getBool("onBoarding") ?? false;
    switch (settings.name) {
      case AppIds.splashScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SplashScreen();
          },
        );

      case AppIds.onBoardingScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return OnBoardingScreen();
          },
        );

      case AppIds.detailsOnBoardingScreen:
        return onBoarding
            ? PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return LoginScreen();
                },
              )
            : FirebaseAuth.instance.currentUser != null
            ? PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return LayoutScreen();
                },
              )
            : PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return DetailsOnBoarding();
                },
              );

      case AppIds.loginSceen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return LoginScreen();
          },
        );

      case AppIds.registerScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return RegisterScreen();
          },
        );
      case AppIds.forgetScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return ForgetScreen();
          },
        );
      case AppIds.layoutScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return LayoutScreen();
          },
        );
      case AppIds.addEventSceen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return AddEvent();
          },
        );
    }
    return null;
  }
}
