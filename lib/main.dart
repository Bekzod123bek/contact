import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_router.dart';
import 'firebase_options.dart';

// 🌍 Storage
import 'core/utils/locale_storage.dart';
import 'core/utils/theme_storage.dart';

// 🎨 Theme
import 'core/theme/app_theme.dart';

// 📦 Data + Cubit
import 'features/contacts/data/contact_remote_datasource.dart';
import 'features/contacts/presentation/cubit/contact_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🌍 Saved locale
  final savedLocale = await LocaleStorage.load();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
      ],
      path: 'lib/localization',
      fallbackLocale: const Locale('en'),
      startLocale: savedLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // 🔑 Global access (theme toggle uchun)
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await ThemeStorage.load();
    setState(() {
      _themeMode = savedTheme;
    });
  }

  void toggleTheme() async {
    final newTheme =
    _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    setState(() {
      _themeMode = newTheme;
    });

    await ThemeStorage.save(newTheme);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      ContactCubit(ContactRemoteDataSource())..loadContacts(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        // 🌍 easy_localization
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,

        // 🎨 Theme
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _themeMode,

        // 🧭 go_router
        routerConfig: router,
      ),
    );
  }
}
