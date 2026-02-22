import 'package:evently/modules/events/model/event_model.dart';
import 'package:evently/modules/events/services/event_services.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LayoutProvider extends ChangeNotifier {
  int currentIndex = 0;
  int tabIndex = 0;

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void onChangeTab(int index) {
    tabIndex = index;
    notifyListeners();
  }

  Future<void> onTapFav(EventModel event) async {
    await EventServices.favToggle(event);
    notifyListeners();
  }

  Future<void> signOutGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  }
}
