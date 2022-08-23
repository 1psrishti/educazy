import 'package:educazy/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      primaryColor: CustomColors.blue,
      cardColor: CustomColors.card,
      disabledColor: CustomColors.disabled,
      buttonColor: CustomColors.button,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: CustomColors.button)));

  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF131313),
      primaryColor: CustomColors.blueDark,
      cardColor: CustomColors.cardDark,
      disabledColor: CustomColors.disabledDark,
      buttonColor: CustomColors.buttonDark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: CustomColors.buttonDark)));
}
