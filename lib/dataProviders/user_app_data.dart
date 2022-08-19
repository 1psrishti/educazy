import 'package:flutter/cupertino.dart';

class UserAppData extends ChangeNotifier {
  Offset? offset;
  String? currentScreen;

  void setOffset(Offset newOffset) {
    offset = newOffset;
    notifyListeners();
  }

  void setCurrentScreen(String screenname) {
    currentScreen = screenname;
    notifyListeners();
  }
}
