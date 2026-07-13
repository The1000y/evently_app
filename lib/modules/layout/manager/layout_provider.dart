import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/modules/events/model/event_model.dart';
import 'package:evently/modules/events/services/event_services.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LayoutProvider extends ChangeNotifier {
  int currentIndex = 0;
  int tabIndex = 0;
  final TextEditingController searchController = TextEditingController();
  bool isLoadingFavorite = false;

  List<QueryDocumentSnapshot<EventModel>> allFavoriteEvents = [];
  List<QueryDocumentSnapshot<EventModel>> filteredFavoriteEvents = [];

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
    allFavoriteEvents.removeWhere((e) => e.data().id == event.id);
    filteredFavoriteEvents.removeWhere((e) => e.data().id == event.id);
    notifyListeners();
  }

  Future<void> getAllFavoriteEvents() async {
    isLoadingFavorite = true;
    notifyListeners();

    allFavoriteEvents = await EventServices.getFavouriteDate();
    filteredFavoriteEvents = allFavoriteEvents;
    isLoadingFavorite = false;
    notifyListeners();
  }

  getAfterSearch(String query) {
    filteredFavoriteEvents = allFavoriteEvents
        .where(
          (element) => element.data().categoryId.toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> signOutGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  }
}
