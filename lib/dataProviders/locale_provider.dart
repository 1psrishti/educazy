import 'package:educazy/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale get locale => _locale ?? Locale('en');

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
