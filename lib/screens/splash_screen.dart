import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/global.dart';
import 'package:educazy/models/user_model.dart';
import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:educazy/screens/home_screen.dart';
import 'package:educazy/utils/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget _child = HomeScreen();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  setupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var key = prefs.getString('key');
    if (key != null) {
      Global.authToken = key;
      UserModel userModel = UserModel.fromJson(prefs.getString('userdata')!);
      Provider.of<UserAppData>(context, listen: false).setUserdata(userModel);
      debugPrint("done");
      setState(() {
        _child = HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/splash.png',
      splashIconSize: 350,
      duration: 4000,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: HomeScreen(),
    );
  }
}