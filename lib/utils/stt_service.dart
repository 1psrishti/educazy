import 'package:educazy/screens/home_screen.dart';
import 'package:educazy/screens/progress_card_screen.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_similarity/string_similarity.dart';

import '../dataProviders/quiz_data_provider.dart';
import '../dataProviders/timer_data.dart';
import '../main.dart';
import '../screens/auth_screens/enroll_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/auth_screens/register_screen.dart';
import '../screens/quiz_screens/quiz_ques.dart';

class SttService {
  SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _text = "";
  double _confidence = 1.0;
  FlutterTts flutterTts = FlutterTts();

  void listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
          onStatus: (val) {
            if (val == "done") {}
            print('$val');
          },
          onError: (val) => print('onError: $val'),
          debugLogging: true);
      if (available) {
        _isListening = true;
        _speechToText.listen(
          listenMode: ListenMode.deviceDefault,
          listenFor: Duration(seconds: 10),
          onResult: (val) {
            _text = val.recognizedWords;

            print(val.recognizedWords);
            // navigateToPage(_text);
            if (val.finalResult) {
              readCommand(_text);
            }

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          },
        );
      }
    } else {
      _isListening = false;
      _speechToText.stop();
    }
  }

  readCommand(String text) async {
    var text1 = text.toLowerCase();
    const targetStrings = <String?>[
      'my user id is',
      'my password is',
      'my fullname is',
      "my school name is",
      "my class name is",
      'my confirm password is',
      'go back',
      'take me to homepage',
      'take me to testscreen',
      'take me to quiz',
      'Take me to class',
      'take me to resources',
      'take me to progress card',
      null
    ];
    final bestMatch = text1.bestMatch(targetStrings);
    switch (bestMatch.bestMatchIndex) {
      case 0:
        {
          text = text.substring(14);
          setText(loginuserIdController, text);
          break;
        }
      case 1:
        {
          text = text.substring(14);
          if (currentscreen == LoginScreen.name) {
            setText(loginpasswordController, text);
          } else if (currentscreen == RegisterScreen.name) {
            setText(registerpasswordController, text);
          }
          break;
        }
      case 2:
        {
          text = text.substring(15).trim();
          setText(enrollnamecontroller, text);
          break;
        }
      case 3:
        {
          text = text.substring(18);
          setText(enrollschoolController, text);
          break;
        }
      case 4:
        {
          text = text.substring(17);
          setText(registerclassController, text);
          break;
        }
      case 5:
        {
          text = text.substring(23);
          setText(registerconfirmpasswordController, text);
          break;
        }
      case 6:
        {
          navigatorKey.currentState!.pop();
          await _speak("Going back");
          break;
        }
      case 7:
        {
          navigatorKey.currentState!.pushNamed(HomeScreen.name);
          await _speak("Taking you to homepage");
          break;
        }
      case 8:
        {
          debugPrint('Not yet Implemented');
          await _speak("Taking you to testscreen");
          break;
        }
      case 9:
        {
          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: ((context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (context) => QuizData()),
                      ChangeNotifierProvider(create: (context) => TimerData()),
                    ],
                    child: const QuizQues(),
                  ))));
          await _speak("Taking you to quiz");
          break;
        }
      case 10:
        {
          debugPrint('Not yet Implemented');
          await _speak("Taking you to class");
          break;
        }
      case 11:
        {
          navigatorKey.currentState!.pushNamed(Resources.name);
          await _speak("Taking you to resources");
          break;
        }
      case 12:
        {
          navigatorKey.currentState!.pushNamed(Progresscard.name);
          await _speak("Taking you to progress card");
          break;
        }
    }

    _speechToText.stop();
    _isListening = false;
  }

  Future _speak(String sentence) async {
    await flutterTts.speak(sentence);
  }

  void setText(TextEditingController controller, value) {
    try {
      controller.text = value;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
