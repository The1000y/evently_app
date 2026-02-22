import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/auth/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices authServices = AuthServices();
  bool isLoading = false;
  bool errorHappen = false;

  Future<void> createAccount(
    BuildContext context, {
    required String email,
    required String password,
    required String name,
  }) async {
    isLoading = true;
    notifyListeners();
    errorHappen = false;
    notifyListeners();

    try {
      await authServices.createUserAccount(
        email: email,
        password: password,
        name: name,
      );
      CherryToast.success(
        title: Text(
          "Pleae Check your email",
          style: TextStyle(color: AppColor.darkModeMainColor),
        ),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorHappen = true;
      notifyListeners();
      CherryToast.error(
        title: Text(e.code, style: TextStyle(color: Colors.red)),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();

      // throw e.message ?? "";
    } catch (e) {
      errorHappen = true;
      notifyListeners();
      CherryToast.error(
        title: Text(e.toString(), style: TextStyle(color: Colors.red)),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginAccount(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    errorHappen = false;
    notifyListeners();
    try {
      var user = await authServices.loginAccount(
        email: email,
        password: password,
      );

      if (user != null && user.emailVerified) {
        CherryToast.success(
          title: Text(
            "Welcom to Evently ${user.displayName}",
            style: TextStyle(color: AppColor.darkModeMainColor),
          ),
          displayCloseButton: false,
          animationType: AnimationType.fromTop,
        ).show(context);
        isLoading = false;
        notifyListeners();
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppIds.layoutScreen,
          (route) => false,
          // (route) => route.settings.name == AppIds.onBoardingScreen,
        );
      } else {
        CherryToast.error(
          title: Text(
            'Email not verified',
            style: TextStyle(color: Colors.red),
          ),
          displayCloseButton: false,
          animationType: AnimationType.fromTop,
        ).show(context);
        user!.sendEmailVerification();
        errorHappen = true;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      errorHappen = true;
      notifyListeners();
      CherryToast.error(
        title: Text(e.message ?? "", style: TextStyle(color: Colors.red)),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorHappen = true;
      notifyListeners();
      CherryToast.error(
        title: Text(e.toString(), style: TextStyle(color: Colors.red)),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resertPassword(
    BuildContext context, {
    required String email,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      await authServices.resetPassword(email: email);
      CherryToast.success(
        title: Text(
          "Please check your email",
          style: TextStyle(color: AppColor.darkModeMainColor),
        ),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      CherryToast.error(
        title: Text(e.message ?? "", style: TextStyle(color: Colors.red)),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      CherryToast.error(
        title: Text(e.toString(), style: TextStyle(color: Colors.red)),
        displayCloseButton: false,
        animationType: AnimationType.fromTop,
      ).show(context);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserCredential?> getSingInGoogle() async {
    return await authServices.signInWithGoogle();
  }
}
