import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/on_boarding/model/on_boarding_details_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsOnBoarding extends StatefulWidget {
  const DetailsOnBoarding({super.key});

  @override
  State<DetailsOnBoarding> createState() => _DetailsOnBoardingState();
}

class _DetailsOnBoardingState extends State<DetailsOnBoarding> {
  final String idName = AppIds.detailsOnBoardingScreen;

  late PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ModelOnBoardingDetails> onBoardingList = [
      ModelOnBoardingDetails(
        image: 'assets/images/hot-trending.png',
        title: AppLocalizations.of(context)!.title_boarding_one,
        body: AppLocalizations.of(context)!.body_boarding_one,
      ),
      ModelOnBoardingDetails(
        image: 'assets/images/manager-desk.png',
        title: AppLocalizations.of(context)!.title_boarding_two,
        body: AppLocalizations.of(context)!.body_boarding_two,
      ),
      ModelOnBoardingDetails(
        image: 'assets/images/being-creative.png',
        title: AppLocalizations.of(context)!.title_boarding_three,
        body: AppLocalizations.of(context)!.body_boarding_three,
      ),
    ];
    var provider = Provider.of<AppProvider>(context);
    var myTheme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            textDirection: TextDirection.ltr,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, AppProvider provider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.heightOf(context) / 20,
                    child: provider.languageType == 'en'
                        ? EnglishCustomStack(
                            onSkip: () => saveOnBoardingState(),
                            currentIndex: currentIndex,
                            controller: controller,
                            myTheme: myTheme,
                            onBoardingList: onBoardingList,
                          )
                        : ArabicCustomStack(
                            onSkip: () => saveOnBoardingState(),
                            currentIndex: currentIndex,
                            controller: controller,
                            myTheme: myTheme,
                            onBoardingList: onBoardingList,
                          ),
                  );
                },
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  controller: controller,
                  itemCount: onBoardingList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            onBoardingList[index].image,
                            color: provider.isDark
                                ? AppColor.darkModeMainTextColor
                                : null,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SmoothPageIndicator(
                controller: controller, // PageController
                count: onBoardingList.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: provider.isDark
                      ? AppColor.darkModeMainColor
                      : AppColor.lightModeMainColor,
                  dotColor: provider.isDark
                      ? AppColor.darkModeMainTextColor
                      : AppColor.darkModeDisableColor,
                ), // your preferred effect
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              SizedBox(height: 24),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Text(
                  onBoardingList[currentIndex].title,

                  style: myTheme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 8),
              Text(
                onBoardingList[currentIndex].body,
                // textAlign: TextAlign.left,
                style: myTheme.textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (currentIndex < onBoardingList.length - 1) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    saveOnBoardingState();
                    Navigator.pushNamed(context, AppIds.loginSceen);
                  }
                },
                child: Center(
                  child: Text(
                    currentIndex == onBoardingList.length - 1
                        ? AppLocalizations.of(context)!.boarding_button_finish
                        : AppLocalizations.of(context)!.boarding_button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveOnBoardingState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("onBoarding", true);
  }
}

class EnglishCustomStack extends StatelessWidget {
  const EnglishCustomStack({
    super.key,
    required this.onSkip,
    required this.currentIndex,
    required this.controller,
    required this.myTheme,
    required this.onBoardingList,
  });

  final int currentIndex;
  final PageController controller;
  final ThemeData myTheme;
  final List<ModelOnBoardingDetails> onBoardingList;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          if (currentIndex > 0)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Card(
                color: provider.isDark
                    ? AppColor.darkModeInputsColor
                    : AppColor.lightModeInputsColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(
                    width: 2,
                    color: provider.isDark
                        ? AppColor.darkModeMainColor.withValues(alpha: 0.3)
                        : AppColor.darkModeDisableColor.withValues(alpha: 0.3),
                  ),
                ),

                child: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    controller.previousPage(
                      duration: Duration(microseconds: 300000),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,

                      color: provider.isDark
                          ? AppColor.darkModeMainTextColor
                          : AppColor.lightModeMainColor,
                    ),
                  ),
                ),
              ),
            ),

          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/logos/logo Evently.png',
                width: 142,

                color: myTheme.primaryColor,
              ),
            ),
          ),

          if (currentIndex < onBoardingList.length - 1)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppIds.loginSceen);
                  onSkip;
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      width: 2,
                      color: provider.isDark
                          ? AppColor.darkModeMainColor.withValues(alpha: 0.3)
                          : AppColor.darkModeDisableColor.withValues(
                              alpha: 0.3,
                            ),
                    ),
                  ),
                  color: provider.isDark
                      ? AppColor.darkModeInputsColor
                      : AppColor.lightModeInputsColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.skip_button,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: provider.isDark
                            ? AppColor.darkModeMainTextColor
                            : AppColor.lightModeMainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ArabicCustomStack extends StatelessWidget {
  const ArabicCustomStack({
    super.key,
    required this.onSkip,
    required this.currentIndex,
    required this.controller,
    required this.myTheme,
    required this.onBoardingList,
  });

  final int currentIndex;
  final PageController controller;
  final ThemeData myTheme;
  final List<ModelOnBoardingDetails> onBoardingList;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Stack(
      children: [
        if (currentIndex < onBoardingList.length - 1)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppIds.loginSceen);
                onSkip;
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(
                    width: 2,
                    color: provider.isDark
                        ? AppColor.darkModeMainColor.withValues(alpha: 0.3)
                        : AppColor.darkModeDisableColor.withValues(alpha: 0.3),
                  ),
                ),
                color: provider.isDark
                    ? AppColor.darkModeInputsColor
                    : AppColor.lightModeInputsColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.skip_button,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: provider.isDark
                          ? AppColor.darkModeMainTextColor
                          : AppColor.lightModeMainColor,
                    ),
                  ),
                ),
              ),
            ),
          ),

        Center(
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/logos/logo Evently.png',
              width: 142,

              color: myTheme.primaryColor,
            ),
          ),
        ),

        if (currentIndex > 0)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Card(
              color: provider.isDark
                  ? AppColor.darkModeInputsColor
                  : AppColor.lightModeInputsColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                  width: 2,
                  color: provider.isDark
                      ? AppColor.darkModeMainColor.withValues(alpha: 0.3)
                      : AppColor.darkModeDisableColor.withValues(alpha: 0.3),
                ),
              ),

              child: IconButton(
                iconSize: 25,
                onPressed: () {
                  controller.previousPage(
                    duration: Duration(microseconds: 300000),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,

                    color: provider.isDark
                        ? AppColor.darkModeMainTextColor
                        : AppColor.lightModeMainColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
