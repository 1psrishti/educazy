import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../main.dart';

void notif(context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await speak(message.notification!.title!);
    // NotificationHelper.updateNotifications(message);

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print(message);
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {}
  });
}

Future<String?> getToken() async {
  String? token;
  var messaging = FirebaseMessaging.instance;
  token = await messaging.getToken();
  print("token: $token");

  //await updateToken(token!, userId);
  return token;
}

updateToken(String token, String userId) async {
  // var doc =
  //     await FirebaseFirestore.instance.collection("users").doc(userId).get();
  // if (doc.exists) {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userId)
  //       .update({"fcm_token": token});
  // }
}

Future speak(String sentence) async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.speak(sentence);
}
