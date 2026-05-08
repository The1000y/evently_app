import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppConstance {
  static List<AppCategory> categories(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return <AppCategory>[
      AppCategory(
        id: 'book',
        image: 'assets/images/Book_Club.png',
        name: local.tab_Book,
        icon: Icons.menu_book_rounded,
      ),
      AppCategory(
        id: 'birthday',
        image: 'assets/images/Birthday.png',
        name: local.tab_Birthday,
        icon: Icons.cake_rounded,
      ),
      AppCategory(
        id: 'exhibition',
        image: 'assets/images/Exhibition.png',
        name: local.tab_Exhibition,
        icon: Icons.museum_rounded,
      ),
      AppCategory(
        id: 'meeting',
        image: 'assets/images/Meeting.png',
        name: local.tab_Meeting,
        icon: Icons.groups_rounded,
      ),
      AppCategory(
        id: 'sport',
        image: 'assets/images/Sport.png',
        name: local.tab_Sport,
        icon: Icons.sports_basketball_rounded,
      ),
    ];
  }
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
