import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/core/widgets/change_selected_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/layout/manager/image_provider.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_popup/flutter_popup.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileSceen extends StatelessWidget {
  const ProfileSceen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    var appProvider = Provider.of<AppProvider>(context);
    var myTheme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16),
              Consumer<ImageProviderManager>(
                builder: (context, provider, child) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: 104,
                        height: 104,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(360),
                          child: provider.imge != null
                              ? Image.file(
                                  provider.imge!,
                                  fit: BoxFit.cover,
                                  key: ValueKey(provider.imgeIndex),
                                )
                              : Image.asset('assets/images/picture.png'),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 85,
                        child: InkWell(
                          onTap: () => provider.getImagePicker(context),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(360),
                            child: Container(
                              color: appProvider.isDark
                                  ? AppColor.darkModeMainColor
                                  : AppColor.lightModeMainColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                currentUser!.displayName ?? "",
                style: myTheme.textTheme.titleLarge,
              ),
              SizedBox(height: 4),
              Text(currentUser.email ?? "", style: myTheme.textTheme.bodySmall),
              SizedBox(height: 24),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: appProvider.isDark
                      ? AppColor.darkModeMainColor.withValues(alpha: 0.1)
                      : AppColor.darkModeMainTextColor,
                  border: BoxBorder.all(
                    color: appProvider.isDark
                        ? AppColor.lightModeMainColor
                        : AppColor.darkModeDisableColor.withValues(alpha: 0.3),
                  ),

                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          local.dark_mode,
                          style: myTheme.textTheme.titleMedium,
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: AppColor.darkModeMainTextColor,
                        inactiveTrackColor: AppColor.darkModeDisableColor
                            .withValues(alpha: 0.3),
                        trackOutlineColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        value: appProvider.isDark,
                        onChanged: (value) {
                          SelectedType type = appProvider.isDark
                              ? SelectedType.button1
                              : SelectedType.button2;
                          appProvider.changeTheme(type);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              PopupMenuButton(
                color: myTheme.primaryColor,
                elevation: 1,
                padding: EdgeInsets.all(0),
                position: PopupMenuPosition.under, // خليها auto
                offset: appProvider.language == 'en'
                    ? Offset(
                        MediaQuery.of(context).size.width - 100,
                        0,
                      ) // يمين الشاشة
                    : Offset(-10, 0), //

                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        appProvider.changeLanguage(SelectedType.button1);
                      },

                      child: Text(
                        local.lang_english,
                        style: myTheme.textTheme.bodySmall!.copyWith(
                          color: AppColor.darkModeMainTextColor,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        appProvider.changeLanguage(SelectedType.button2);
                      },
                      child: Text(
                        local.lang_arabic,
                        style: myTheme.textTheme.bodySmall!.copyWith(
                          color: AppColor.darkModeMainTextColor,
                        ),
                      ),
                    ),
                  ];
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: appProvider.isDark
                        ? AppColor.darkModeMainColor.withValues(alpha: 0.1)
                        : AppColor.darkModeMainTextColor,
                    border: BoxBorder.all(
                      color: appProvider.isDark
                          ? AppColor.lightModeMainColor
                          : AppColor.darkModeDisableColor.withValues(
                              alpha: 0.3,
                            ),
                    ),

                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            local.language,
                            style: myTheme.textTheme.titleMedium,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: myTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Consumer<LayoutProvider>(
                builder: (context, provider, child) {
                  return GestureDetector(
                    onTap: () async {
                      await provider.signOutGoogle();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppIds.loginSceen,
                        (route) => false,
                      );
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: appProvider.isDark
                            ? AppColor.darkModeMainColor.withValues(alpha: 0.1)
                            : AppColor.darkModeMainTextColor,
                        border: BoxBorder.all(
                          color: appProvider.isDark
                              ? AppColor.lightModeMainColor
                              : AppColor.darkModeDisableColor.withValues(
                                  alpha: 0.3,
                                ),
                        ),

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                local.logout,
                                style: myTheme.textTheme.titleMedium,
                              ),
                            ),
                            Icon(
                              Iconsax.logout4,
                              color: AppColor.darkModeRedColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
