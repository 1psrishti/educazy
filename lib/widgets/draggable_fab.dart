import 'dart:async';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:educazy/HelperMethods/helper_methods.dart';
import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/main.dart';
import 'package:educazy/screens/auth_screens/enroll_screen.dart';
import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:educazy/screens/auth_screens/register_screen.dart';

import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/utils/custom_colors.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_similarity/string_similarity.dart';

import '../screens/home_screen.dart';
import '../screens/progress_card_screen.dart';
import 'circular_menu_item.dart';
import 'custom_circular_menu.dart';

class DraggableFloatingActionButton extends StatefulWidget {
  final Alignment initialOffset;

  final Widget child;

  const DraggableFloatingActionButton({
    Key? key,
    required this.initialOffset,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  final GlobalKey _key = GlobalKey();

  bool _isDragging = false;
  late Offset _offset;
  late Offset _minOffset;
  late Offset _maxOffset;
  SpeechToText? _speechToText;
  bool _isListening = false;
  String _text = "";
  double _confidence = 1.0;
  FlutterTts flutterTts = FlutterTts();

  @override
  @override
  void dispose() {
    super.dispose();
    _speechToText!.stop();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText!.initialize(
          onStatus: (val) {
            if (val == "done") {}
            debugPrint(val);
          },
          onError: (val) => debugPrint('onError: $val'),
          debugLogging: true);
      if (available) {
        setState(() => _isListening = true);
        _speechToText!.listen(
          listenMode: ListenMode.deviceDefault,
          listenFor: const Duration(seconds: 10),
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            debugPrint(val.recognizedWords);
            // navigateToPage(_text);
            if (val.finalResult) {
              readCommand(_text);
            }

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText!.stop();
    }
  }

  @override
  void initState() {
    super.initState();

    _speechToText = SpeechToText();

    //WidgetsBinding.instance.addPostFrameCallback(_setBoundary);
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
    Provider.of<UserAppData>(context, listen: false).setOffset(_offset);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.2,
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).cardColor,
        leading: ImageIcon(
          const AssetImage('assets/images/logo.png'),
          color: Theme.of(context).primaryColor,
          size: 33,
        ),
        leadingWidth: 45,
        title: Text(
          'educazy',
          style: GoogleFonts.squadaOne(
              fontSize: 21, color: Theme.of(context).primaryColor),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.blue.withOpacity(0.05)),
                child: Center(
                  child: Icon(
                    Icons.help_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Badge(
                badgeColor: const Color(0xFFD84F4F),
                badgeContent: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    notifNo.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                toAnimate: true,
                position: BadgePosition.topEnd(end: 0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColors.blue.withOpacity(0.05)),
                  child: Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
      body: CircularMenu(
        toggleButtonAnimatedIconData: AnimatedIcons.play_pause,
        startingAngleInRadian: 1 * pi,
        endingAngleInRadian: 1.5 * pi,
        alignment: widget.initialOffset,

        items: [
          CircularMenuItem(
              iconSize: 20,
              icon: themeProvider.isDarkMode
                  ? Icons.dark_mode
                  : Icons.dark_mode_outlined,
              onTap: () {
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(!(themeProvider.isDarkMode));
              }),
          CircularMenuItem(
              iconSize: 20,
              icon: Icons.text_format,
              onTap: () {
                //callback
                HelperMethods.toggleFont(context);
              }),
          CircularMenuItem(
              iconSize: 20,
              icon: Icons.settings,
              onTap: () {
                //callback
              }),
        ],
        backgroundWidget: widget.child,
        // child: GestureDetector(
        //   onTap: () {
        //     _listen();
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50),
        //         color: Color(0xFF5BB92F)),
        //     padding: EdgeInsets.all(20),
        //     child: Icon(
        //       _isListening ? Icons.mic : Icons.mic_none,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ),
    );
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
          setText(logInUserIdController, text);
          break;
        }
      case 1:
        {
          text = text.substring(14);
          if (currentscreen == LoginScreen.name) {
            setText(logInPasswordController, text);
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
    setState(() {
      _text = "";
    });
    setState(() => _isListening = false);
    _speechToText!.stop();
  }

  navigateToPage(String route) async {
    route = route.toLowerCase();
    switch (route) {
      case 'go back':
        {
          navigatorKey.currentState!.pop();
          await _speak("Going back");
          break;
        }
      case 'take me to homepage':
        {
          navigatorKey.currentState!.pushNamed(HomeScreen.name);
          await _speak("Taking you to homepage");
          break;
        }
      case 'take me to testscreen':
        {
          debugPrint('Not yet Implemented');
          await _speak("Taking you to testscreen");
          break;
        }
      case 'take me to quiz':
        {
          navigatorKey.currentState!.pushNamed(QuizQues.name);
          await _speak("Taking you to quiz");
          break;
        }
      case 'Take me to class':
        {
          debugPrint('Not yet Implemented');
          await _speak("Taking you to class");
          break;
        }
      case 'take me to resources':
        {
          navigatorKey.currentState!.pushNamed(Resources.name);
          await _speak("Taking you to resources");
          break;
        }
      case 'take me to progress card':
        {
          navigatorKey.currentState!.pushNamed(Progresscard.name);
          await _speak("Taking you to progress card");
          break;
        }
    }
    setState(() {
      _text = "";
    });
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

/*
  return Stack(
      children: [
        Positioned(
          right: _offset.dx - 200,
          top: _offset.dy + 14,
          child: AnimatedContainer(
            padding: const EdgeInsets.all(5),
            duration: Duration(milliseconds: 500),
            constraints: BoxConstraints(minWidth: 0),
            child: Text(
              _text,
              style: TextStyle(fontSize: 18, decoration: TextDecoration.none),
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
          ),
        ),
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: Stack(
            children: [
              Container(
                key: _key,
                child: GestureDetector(
                  onTap: () {
                    _listen();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF5BB92F)),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    */

/*
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        leading: ImageIcon(
          AssetImage('assets/images/logo.png'),
          color: CustomColors.blue,
          size: 33,
        ),
        leadingWidth: 45,
        title: Text(
          'Educazy',
          style: GoogleFonts.squadaOne(fontSize: 21, color: CustomColors.blue),
        ),
        actions: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColors.blue.withOpacity(0.05)),
                  child: Center(
                      child: ImageIcon(
                    AssetImage('assets/images/help-circle.png'),
                    color: CustomColors.blue,
                    size: 25,
                  )),
                ),
                const SizedBox(
                  width: 26,
                ),
                Badge(
                  badgeColor: const Color(0xFFD84F4F),
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      notifNo.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  toAnimate: true,
                  position: BadgePosition.topEnd(end: 0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.blue.withOpacity(0.05)),
                    child: Center(
                        child: ImageIcon(

                      color: CustomColors.blue,
                      size: 25,
                    )),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          )
        ],
      ),
      */
