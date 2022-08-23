import 'package:camera/camera.dart';
import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/models/user_model.dart';
import 'package:educazy/screens/account_settings_screen.dart';
import 'package:educazy/screens/auth_screens/enroll_screen.dart';
import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:educazy/screens/auth_screens/register_screen.dart';
import 'package:educazy/screens/home_screen.dart';
import 'package:educazy/screens/profile_screen.dart';
import 'package:educazy/screens/progress_card_screen.dart';

import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/screens/speech_demo.dart';
import 'package:educazy/screens/splash_screen.dart';
import 'package:educazy/screens/test_portal_screen.dart';
import 'package:educazy/utils/route_aware_widget.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/utils/webview_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'new_email_arrived', // id
    'High Importance Notifications', // title

    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // AlertHelper.speak(message.notification!.title!, "en");
  //await AlertHelper.manageNotif(message.notification!.title!);
  // NotificationHelper.updateNotifications(message);
  print('A bg message just showed up :  ${message.messageId}');
  print(message.data);
}

List<CameraDescription>? cameras;
String currentscreen = LoginScreen.name;
String fcmToken = "";
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Permission.camera.request();
  // await Permission.microphone.request();

  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => UserAppData())),
          ChangeNotifierProvider(create: ((context) => ThemeProvider()))
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            navigatorKey: navigatorKey,
            theme: MyThemes.lightTheme,
            navigatorObservers: [routeObserver],
            home: HomeScreen(),
            routes: {
              HomeScreen.name: (context) =>
                  RouteAwareWidget(HomeScreen.name, child: HomeScreen()),
              EnrollScreen.name: (context) => const RouteAwareWidget(
                  EnrollScreen.name,
                  child: EnrollScreen()),
              LoginScreen.name: (context) => const RouteAwareWidget(
                  LoginScreen.name,
                  child: LoginScreen()),
              RegisterScreen.name: (context) => const RouteAwareWidget(
                  RegisterScreen.name,
                  child: RegisterScreen()),
              QuizQues.name: (context) =>
                  const RouteAwareWidget(QuizQues.name, child: QuizQues()),
              Progresscard.name: (context) => const RouteAwareWidget(
                  Progresscard.name,
                  child: Progresscard()),
              Resources.name: (context) =>
                  const RouteAwareWidget(Resources.name, child: Resources()),
              TestPortal.name: (context) =>
                  RouteAwareWidget(TestPortal.name, child: const TestPortal()),
              AccountSettingsScreen.name: (context) => const RouteAwareWidget(
                  AccountSettingsScreen.name,
                  child: AccountSettingsScreen())
            },
          );
        });
  }
}
