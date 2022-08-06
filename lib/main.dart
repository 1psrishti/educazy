import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/models/user_model.dart';
import 'package:educazy/screens/auth_screens/enroll_screen.dart';
import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:educazy/screens/auth_screens/register_screen.dart';
import 'package:educazy/screens/homescreen.dart';
import 'package:educazy/screens/progress_card.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/screens/speech_demo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final CubeUser currentUser = CubeUser(
  id: 6042955,
  login: "kartikeymahawar1234@gmail.com",
  fullName: "Kartikey",
  password: "#321urak",
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => UserAppData()),
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(fontFamily: "Poppins"),
        navigatorObservers: [routeObserver],
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ((context) => UserAppData())),
          ],
          child: LoginScreen(),
        ),
        routes: {
          HomeScreen.name: (context) => HomeScreen(currentuser: currentUser),
          EnrollScreen.name: (context) => const EnrollScreen(),
          LoginScreen.name: (context) => const LoginScreen(),
          RegisterScreen.name: (context) => const RegisterScreen(),
          QuizQues.name: (context) => const QuizQues(),
          Progresscard.name: (context) => const Progresscard(),
          Resources.name: (context) => const Resources()
        },
      ),
    );
  }
}
