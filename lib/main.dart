import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'firebase_options.dart';

// 🎨 Theme
import 'core/theme/app_theme.dart';

// DATA + CUBIT
import 'features/contacts/data/contact_remote_datasource.dart';
import 'features/contacts/presentation/cubit/contact_cubit.dart';

// UI
import 'features/contacts/presentation/pages/contact_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
      ],
      path: 'lib/localization',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // 🔑 GLOBAL ACCESS (theme o‘zgartirish uchun)
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

        // 🌍 easy_localization
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,

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
