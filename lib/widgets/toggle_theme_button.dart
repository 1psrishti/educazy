import 'package:educazy/dataProviders/locale_provider.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CupertinoSwitch(
        value: themeProvider.isDarkMode,
        onChanged: (val) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(val);
        });
  }
}

class ToggleLanguage extends StatelessWidget {
  const ToggleLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LocaleProvider>(context);
    return CupertinoSwitch(
        value: langProvider.locale == Locale('hi'),
        onChanged: (val) {
          final provider = Provider.of<LocaleProvider>(context, listen: false);
          provider.setLocale(!val ? Locale('en') : Locale('hi'));
        });
  }
}
