import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:evently/modules/layout/pages/favorite_screen.dart';
import 'package:evently/modules/layout/pages/home_Screen.dart';
import 'package:evently/modules/layout/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  final String id = AppIds.layoutScreen;

  @override
  Widget build(BuildContext context) {
    List<Widget> MyScreen = [HomeScreen(), FavoriteScreen(), ProfileSceen()];
    var appProvider = context.read<AppProvider>();
    return ChangeNotifierProvider<LayoutProvider>(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(child: MyScreen[provider.currentIndex]),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 12,
                    color: appProvider.isDark
                        ? AppColor.darkModeMainColor.withValues(alpha: .3)
                        : AppColor.lightModeMainColor.withValues(alpha: 0.3),
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: FloatingActionButton(
                elevation: 1,
                onPressed: () {
                  Navigator.pushNamed(context, AppIds.addEventSceen);
                },
                child: Icon(Iconsax.add),
              ),
            ),

            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: (value) {
                  provider.onChange(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home),
                    label: 'Home',
                    activeIcon: Icon(Iconsax.home_25),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.heart),
                    label: 'Favorite',
                    activeIcon: Icon(Iconsax.heart5),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.user),
                    label: 'Pofile',
                    activeIcon: Icon(Icons.person, size: 25),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
