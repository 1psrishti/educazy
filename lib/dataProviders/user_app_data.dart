import 'package:flutter/cupertino.dart';

class UserAppData extends ChangeNotifier {
  Offset? offset;

  void setOffset(Offset newOffset) {
    offset = newOffset;
    notifyListeners();
  }
}
