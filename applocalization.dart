// ─────────────────────────────────────────────
//  LOCALIZATION: AppLocalizations
//  Loads en.json / ur.json from assets at runtime.
//  No code-gen required — simple JSON lookup.
//
//  Usage:
//    final s = AppLocalizations.of(context);
//    Text(s.t('myProfile'))
// ─────────────────────────────────────────────

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_profile.dart';
class AppLocalizations {
  final Locale locale;
  late Map<String, String> _strings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en')).._strings = {};
  }

  /// Translate a key. Falls back to the key itself if missing.
  String t(String key, {Map<String, String>? args}) {
    String result = _strings[key] ?? key;
    args?.forEach((k, v) => result = result.replaceAll('{$k}', v));
    return result;
  }

  Future<void> load() async {
    final langCode = locale.languageCode;
    // Try requested language, fall back to English
    String jsonString;
    try {
      jsonString = await rootBundle
          .loadString('assets/l10n/$langCode.json');
    } catch (_) {
      jsonString = await rootBundle.loadString('assets/l10n/en.json');
    }
    final Map<String, dynamic> decoded = json.decode(jsonString);
    _strings = decoded.map((k, v) => MapEntry(k, v.toString()));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ur'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}