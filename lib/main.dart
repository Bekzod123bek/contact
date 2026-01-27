import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';

// 🌍 Localization
import 'localization/app_localizations.dart';

// 🎨 Theme
import 'core/theme/app_theme.dart';


// DATA + CUBIT
import 'features/contacts/data/contact_remote_datasource.dart';
import 'features/contacts/presentation/cubit/contact_cubit.dart';

// UI
import 'features/contacts/presentation/pages/contact_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // 🔑 GLOBAL ACCESS (til + theme o‘zgartirish uchun)
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 🌍 LANGUAGE
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // 🎨 THEME
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactCubit(ContactRemoteDataSource())..loadContacts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // 🌍 LANGUAGE
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('uz'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // 🎨 THEME
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _themeMode,

        // 🏠 HOME
        home: const ContactListPage(),
      ),
    );
  }
}
