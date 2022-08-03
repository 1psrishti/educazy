import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        themeMode: ThemeMode.system,
        theme: ThemeData(fontFamily: "Poppins"),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ((context) => UserAppData())),
          ],
          child: LoginScreen(),
        ),
      ),
    );
  }
}
