import 'package:alan_voice/alan_voice.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/main.dart';
import 'package:educazy/screens/homescreen.dart';
import 'package:educazy/screens/progress_card.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dataProviders/quiz_data_provider.dart';

class AlanAiHelper {
  static initAlanButton() {
    AlanVoice.addButton(
        "114f2bd0350d71189209e8fa2b0ca1d92e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    AlanVoice.callbacks.add((command) => _handleCommands(command.data));
  }

  static void setVisualState(String name) {
    var visuals = "{\"screen\":\"$name\"}";
    AlanVoice.setVisualState(visuals);
  }

  static void _handleCommands(Map<String, dynamic> command) {
    debugPrint("New command: $command");
    switch (command["command"]) {
      case 'navigation':
        {
          navigateToPage(command['route']);
          break;
        }
    }
  }

  static void navigateToPage(String route) {
    switch (route) {
      case 'back':
        {
          navigatorKey.currentState!.pop();
          break;
        }
      case 'homepage':
        {
          //navigatorKey.currentState!.pushNamed(HomeScreen.name);
          break;
        }
      case 'test':
        {
          debugPrint('Not yet Implemented');
          break;
        }
      case 'quiz':
        {
          navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => MultiProvider(providers: [
              ChangeNotifierProvider(create: ((context) => QuizData())),
              ChangeNotifierProvider(create: ((context) => TimerData())),
            ], child: QuizQues()),
          ));
          break;
        }
      case 'class':
        {
          debugPrint('Not yet Implemented');
          break;
        }
      case 'res':
        {
          navigatorKey.currentState!.pushNamed(Resources.name);
          break;
        }
      case 'progress':
        {
          navigatorKey.currentState!.pushNamed(Progresscard.name);
          break;
        }
    }
  }
}
