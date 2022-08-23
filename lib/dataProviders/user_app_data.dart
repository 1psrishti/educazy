import 'package:educazy/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserAppData extends ChangeNotifier {
  Offset? offset;
  String? currentScreen;
  UserModel? userModel;
  String? authToken;

  void setOffset(Offset newOffset) {
    offset = newOffset;
    notifyListeners();
  }

  void setCurrentScreen(String screenname) {
    currentScreen = screenname;
    notifyListeners();
  }

  void setUserdata(UserModel userModel) {
    this.userModel = userModel;
    notifyListeners();
  }

  void setAuthToken(String authToken) {
    this.authToken = authToken;
    notifyListeners();
  }
}
