import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/enums/font_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static toggleFont(BuildContext context) {
    var font = Provider.of<UserAppData>(context, listen: false).font;
    if (font == CustomFont.small) {
      Provider.of<UserAppData>(context, listen: false)
          .setFont(CustomFont.medium);
    } else if (font == CustomFont.medium) {
      Provider.of<UserAppData>(context, listen: false)
          .setFont(CustomFont.large);
    } else {
      Provider.of<UserAppData>(context, listen: false)
          .setFont(CustomFont.small);
    }
  }
}
