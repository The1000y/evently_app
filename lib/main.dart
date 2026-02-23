import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/route/get_helper.dart';
import 'package:evently/core/route/route_gen.dart';
import 'package:evently/core/themes/app_theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      appId: dotenv.env['APP_ID']!,
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['PROJECT_ID']!,
    ),
  );
  // تحميل ملف .env
  await dotenv.load(fileName: ".env");
  await GetHelper.init();
  AppProvider provider = AppProvider();
  provider.loadLanguage();
  provider.loadTheme();
  runApp(
    ChangeNotifierProvider<AppProvider>.value(value: provider, child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      onGenerateRoute: RouteGen.generateRoute,
      locale: Locale(provider.language),
      title: 'Evently',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Arabic
      ],
      themeMode: provider.themeMode,
      theme: AppTheme.lightTheme(provider.language),
      darkTheme: AppTheme.darkTheme(provider.language),
      debugShowCheckedModeBanner: false,
    );
  }
}
