import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Evently'**
  String get app_name;

  /// No description provided for @onboarding_title.
  ///
  /// In en, this message translates to:
  /// **'Customize Your Experience'**
  String get onboarding_title;

  /// No description provided for @onboarding_desc.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language and theme to start with a comfortable experience tailored just for you.'**
  String get onboarding_desc;

  /// No description provided for @language_label.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_label;

  /// No description provided for @theme_label.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme_label;

  /// No description provided for @lang_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang_english;

  /// No description provided for @lang_arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get lang_arabic;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @start_button.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get start_button;

  /// No description provided for @title_boarding_one.
  ///
  /// In en, this message translates to:
  /// **'Discover Events That Inspire You'**
  String get title_boarding_one;

  /// No description provided for @title_boarding_two.
  ///
  /// In en, this message translates to:
  /// **'Organize Events Easily'**
  String get title_boarding_two;

  /// No description provided for @title_boarding_three.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends and Share Moments'**
  String get title_boarding_three;

  /// No description provided for @body_boarding_one.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a world of events tailored to your unique interests. Whether you love live music, art workshops, professional meetups, or discovering new experiences, you’ll always find something exciting. Our curated recommendations help you explore, connect, and make the most of every opportunity around you.'**
  String get body_boarding_one;

  /// No description provided for @body_boarding_two.
  ///
  /// In en, this message translates to:
  /// **'Take the stress out of event planning with our all-in-one tools. From sending invitations and managing RSVPs to scheduling reminders and organizing details, we handle everything for you. Plan effortlessly and focus on what matters most — creating unforgettable experiences for you and your guests.'**
  String get body_boarding_two;

  /// No description provided for @body_boarding_three.
  ///
  /// In en, this message translates to:
  /// **'Make every event more meaningful by sharing it with others. Our platform lets you invite friends, keep everyone updated, and celebrate moments together. Capture memories and share the excitement with your network to relive the best experiences.'**
  String get body_boarding_three;

  /// No description provided for @boarding_button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get boarding_button;

  /// No description provided for @boarding_button_finish.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get boarding_button_finish;

  /// No description provided for @skip_button.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip_button;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcome_back;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get language;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorite;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @tab_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tab_all;

  /// No description provided for @tab_Book.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get tab_Book;

  /// No description provided for @tab_Birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get tab_Birthday;

  /// No description provided for @tab_Exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get tab_Exhibition;

  /// No description provided for @tab_Meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get tab_Meeting;

  /// No description provided for @tab_Sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get tab_Sport;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get login_title;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get email_hint;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_hint;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dont_have_account;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_with_google;

  /// No description provided for @create_account_title.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get create_account_title;

  /// No description provided for @name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get name_hint;

  /// No description provided for @confirm_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirm_password_hint;

  /// No description provided for @signup_button.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup_button;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @enter_email_error.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_email_error;

  /// No description provided for @invalid_email_error.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalid_email_error;

  /// No description provided for @enter_password_error.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_password_error;

  /// No description provided for @password_short_error.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_short_error;

  /// No description provided for @confirm_password_error.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirm_password_error;

  /// No description provided for @password_not_match_error.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_not_match_error;

  /// No description provided for @wrong_password_error.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrong_password_error;

  /// No description provided for @email_already_in_use_error.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get email_already_in_use_error;

  /// No description provided for @user_not_found_error.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get user_not_found_error;

  /// No description provided for @network_error.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection'**
  String get network_error;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get unknown_error;

  /// No description provided for @enter_name_error.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enter_name_error;

  /// No description provided for @name_short_error.
  ///
  /// In en, this message translates to:
  /// **'Name is too short'**
  String get name_short_error;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
