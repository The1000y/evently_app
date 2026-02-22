import 'package:flutter/material.dart';

ThemeData themeApp(BuildContext context) {
  var myTheme = Theme.of(context);

  return myTheme;
}

class Loading {
  static bool _isLoading = false;
  static void showLoading(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(
              color: themeApp(context).primaryColor,
            ),
          ),
        );
      },
    ).then((value) => _isLoading = false);
    _isLoading = false;
  }

  static void hideLoading(BuildContext context) {
    if (_isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
      _isLoading = false;
    }
  }
}
