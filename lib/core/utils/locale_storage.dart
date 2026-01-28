import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocaleStorage {
  static const _key = 'locale';

  static Future<void> save(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  static Future<Locale?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code == null) return null;
    return Locale(code);
  }
}
