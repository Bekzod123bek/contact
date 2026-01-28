import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/locale_storage.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    Widget btn(String code) => TextButton(
      onPressed: () {
        final locale = Locale(code);
        context.setLocale(locale);
        LocaleStorage.save(locale);
      },
      child: Text(
        code.toUpperCase(),
        style: TextStyle(
          color: lang == code ? Colors.grey : Colors.white,
        ),
      ),
    );

    return Row(children: [btn('en'), btn('uz')]);
  }
}

