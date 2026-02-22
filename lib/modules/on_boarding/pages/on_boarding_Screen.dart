// ignore: file_names
import 'package:animate_do/animate_do.dart';
import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/core/widgets/change_selected_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  final String idName = AppIds.onBoardingScreen;

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Center(
                      child: Image.asset(
                        'assets/logos/logo Evently.png',
                        width: 140,
                        color: myTheme.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeIn(
                      delay: Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          SizedBox(height: 24),
                          Center(
                            child: Image.asset(
                              'assets/images/image beingcreative.png',
                              color: provider.isDark ? Colors.white : null,
                              // color: provider.themeMode == ThemeMode.dark
                              //     ? Colors.white
                              //     : null,
                            ),
                          ),
                          SizedBox(height: 24),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text(
                              AppLocalizations.of(context)!.onboarding_title,
                              style: myTheme.textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.onboarding_desc,
                            style: myTheme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 16),

                          CustomRowChoose(
                            ontap: provider.changeLanguage,
                            textOfRow: AppLocalizations.of(
                              context,
                            )!.language_label,
                            type: provider.languageType,
                            child1: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.lang_english,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      provider.languageType ==
                                          SelectedType.button1
                                      ? AppColor.lightModeInputsColor
                                      : provider.isDark
                                      ? myTheme.primaryColorLight
                                      : myTheme.primaryColor,
                                ),
                              ),
                            ),
                            child2: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.lang_arabic,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      provider.languageType ==
                                          SelectedType.button2
                                      ? AppColor.lightModeInputsColor
                                      : provider.isDark
                                      ? AppColor.lightModeInputsColor
                                      : myTheme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          CustomRowChoose(
                            ontap: provider.changeTheme,
                            textOfRow: AppLocalizations.of(
                              context,
                            )!.theme_label,
                            type: provider.themeType,
                            child1: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              child: provider.themeType == SelectedType.button1
                                  ? Icon(
                                      Icons.light_mode,
                                      color: AppColor.lightModeInputsColor,
                                    )
                                  : Icon(
                                      Icons.light_mode_outlined,
                                      color: provider.isDark
                                          ? myTheme.primaryColorLight
                                          : myTheme.primaryColor,
                                    ),
                            ),
                            child2: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              child: provider.themeType == SelectedType.button2
                                  ? Icon(
                                      Icons.dark_mode,
                                      color: AppColor.lightModeInputsColor,
                                    )
                                  : Icon(
                                      Icons.dark_mode_outlined,
                                      color: myTheme.primaryColor,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  FadeInUpBig(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 400),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppIds.detailsOnBoardingScreen,
                        );
                      },
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.start_button),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
