import 'package:flutter/material.dart';

class AppConstance {
  static List<AppCategory> get categories => [
    AppCategory(
      id: 'book',
      image: 'assets/images/Book_Club.png',
      name: 'Book',
      icon: Icons.menu_book_rounded,
    ),
    AppCategory(
      id: 'birthday',
      image: 'assets/images/Birthday.png',
      name: 'Birthday',
      icon: Icons.cake_rounded,
    ),
    AppCategory(
      id: 'exhibition',
      image: 'assets/images/Exhibition.png',
      name: 'Exhibition',
      icon: Icons.museum_rounded,
    ),
    AppCategory(
      id: 'meeting',
      image: 'assets/images/Meeting.png',
      name: 'Meeting',
      icon: Icons.groups_rounded,
    ),
    AppCategory(
      id: 'sport',
      image: 'assets/images/Sport.png',
      name: 'Sport',
      icon: Icons.sports_basketball_rounded,
    ),
  ];
}

class AppCategory {
  String id;
  String name;
  String image;
  IconData icon;

  AppCategory({
    required this.id,
    required this.image,
    required this.name,
    required this.icon,
  });
}
