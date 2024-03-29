import 'dart:math' as math;

import 'package:educazy/dataProviders/locale_provider.dart';
import 'package:educazy/enums/font_enum.dart';
import 'package:educazy/screens/classes_screen.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:translator/translator.dart';
import '../screens/auth_screens/login_screen.dart';
import '../dataProviders/quiz_data_provider.dart';
import '../dataProviders/timer_data.dart';
import '../dataProviders/user_app_data.dart';
import '../main.dart';
import '../screens/auth_screens/enroll_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/auth_screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/progress_card_screen.dart';
import '../screens/quiz_screens/quiz_ques.dart';
import '../screens/resources_screen.dart';
import 'circular_menu_item.dart';
import 'package:educazy/utils/stt_service.dart';

class CircularMenu extends StatefulWidget {
  /// use global key to control animation anywhere in the code
  final GlobalKey<CircularMenuState>? key;

  /// list of CircularMenuItem contains at least two items.
  final List<CircularMenuItem> items;

  /// menu alignment
  final AlignmentGeometry alignment;

  /// menu radius
  final double radius;

  /// widget holds actual page content
  final Widget? backgroundWidget;

  /// animation duration
  final Duration animationDuration;

  /// animation curve in forward
  final Curve curve;

  /// animation curve in rverse
  final Curve reverseCurve;

  /// callback
  final VoidCallback? toggleButtonOnPressed;
  final Color? toggleButtonColor;
  final double toggleButtonSize;
  final List<BoxShadow>? toggleButtonBoxShadow;
  final double toggleButtonPadding;
  final double toggleButtonMargin;
  final Color? toggleButtonIconColor;
  final AnimatedIconData toggleButtonAnimatedIconData;

  /// staring angle in clockwise radian
  final double? startingAngleInRadian;

  /// ending angle in clockwise radian
  final double? endingAngleInRadian;

  /// creates a circular menu with specific [radius] and [alignment] .
  /// [toggleButtonElevation] ,[toggleButtonPadding] and [toggleButtonMargin] must be
  /// equal or greater than zero.
  /// [items] must not be null and it must contains two elements at least.
  CircularMenu({
    required this.items,
    this.alignment = Alignment.bottomCenter,
    this.radius = 100,
    this.backgroundWidget,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.bounceOut,
    this.reverseCurve = Curves.fastOutSlowIn,
    this.toggleButtonOnPressed,
    this.toggleButtonColor,
    this.toggleButtonBoxShadow,
    this.toggleButtonMargin = 10,
    this.toggleButtonPadding = 10,
    this.toggleButtonSize = 40,
    this.toggleButtonIconColor,
    this.toggleButtonAnimatedIconData = AnimatedIcons.menu_close,
    this.key,
    this.startingAngleInRadian,
    this.endingAngleInRadian,
  })  : assert(items.isNotEmpty, 'items can not be empty list'),
        assert(items.length > 1, 'if you have one item no need to use a Menu'),
        super(key: key);

  @override
  CircularMenuState createState() => CircularMenuState();
}

class CircularMenuState extends State<CircularMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double? _completeAngle;
  late double _initialAngle;
  double? _endAngle;
  double? _startAngle;
  late int _itemsCount;
  late Animation<double> _animation;

  /// forward animation
  void forwardAnimation() {
    _animationController.forward();
  }

  /// reverse animation
  void reverseAnimation() {
    _animationController.reverse();
  }

  @override
  void initState() {
    _configure();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve),
    );
    _itemsCount = widget.items.length;
    super.initState();
  }

  void _configure() {
    if (widget.startingAngleInRadian != null ||
        widget.endingAngleInRadian != null) {
      if (widget.startingAngleInRadian == null) {
        throw ('startingAngleInRadian can not be null');
      }
      if (widget.endingAngleInRadian == null) {
        throw ('endingAngleInRadian can not be null');
      }

      if (widget.startingAngleInRadian! < 0) {
        throw 'startingAngleInRadian has to be in clockwise radian';
      }
      if (widget.endingAngleInRadian! < 0) {
        throw 'endingAngleInRadian has to be in clockwise radian';
      }
      _startAngle = (widget.startingAngleInRadian! / math.pi) % 2;
      _endAngle = (widget.endingAngleInRadian! / math.pi) % 2;
      if (_endAngle! < _startAngle!) {
        throw 'startingAngleInRadian can not be greater than endingAngleInRadian';
      }
      _completeAngle = _startAngle == _endAngle
          ? 2 * math.pi
          : (_endAngle! - _startAngle!) * math.pi;
      _initialAngle = _startAngle! * math.pi;
    } else {
      switch (widget.alignment.toString()) {
        case 'Alignment.bottomCenter':
          _completeAngle = 1 * math.pi;
          _initialAngle = 1 * math.pi;
          break;
        case 'Alignment.topCenter':
          _completeAngle = 1 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'Alignment.centerLeft':
          _completeAngle = 1 * math.pi;
          _initialAngle = 1.5 * math.pi;
          break;
        case 'Alignment.centerRight':
          _completeAngle = 1 * math.pi;
          _initialAngle = 0.5 * math.pi;
          break;
        case 'Alignment.center':
          _completeAngle = 2 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'Alignment.bottomRight':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 1 * math.pi;
          break;
        case 'Alignment.bottomLeft':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 1.5 * math.pi;
          break;
        case 'Alignment.topLeft':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'Alignment.topRight':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 0.5 * math.pi;
          break;
        default:
          throw 'startingAngleInRadian and endingAngleInRadian can not be null';
      }
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    _configure();
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _buildMenuItems() {
    List<Widget> items = [];
    widget.items.asMap().forEach((index, item) {
      items.add(
        Positioned.fill(
          child: Align(
            alignment: widget.alignment,
            child: Transform.translate(
              offset: Offset.fromDirection(
                  _completeAngle == (2 * math.pi)
                      ? (_initialAngle +
                          (_completeAngle! / (_itemsCount)) * index)
                      : (_initialAngle +
                          (_completeAngle! / (_itemsCount - 1)) * index),
                  _animation.value * widget.radius),
              child: Transform.scale(
                scale: _animation.value,
                child: Transform.rotate(
                  angle: _animation.value * (math.pi * 2),
                  child: item,
                ),
              ),
            ),
          ),
        ),
      );
    });
    return items;
  }

  SpeechToText _speechToText = SpeechToText();
  bool isListening = false;
  String text = "";
  double _confidence = 1.0;
  FlutterTts flutterTts = FlutterTts();

  Widget _buildMenuButton(BuildContext context) {
    void setText(TextEditingController controller, value) {
      try {
        controller.text = value;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    Future _speak(String sentence) async {
      await flutterTts.speak(sentence);
    }

    readCommandHindi(String text) async {
      final translator = GoogleTranslator();
      const targetStrings = <String?>[
        'मेरी यूजर आईडी है ', //0
        'मेरी user id आईडी है ', //1
        'my password is', //2
        'my fullname is', //3
        "my school name is", //4
        "my class name is", //5
        'my confirm password is', //6
        'वापस जाओ', //7
        'मुझे होमपेज पर ले चलो', //8
        'मुझे टेस्टस्क्रीन पर ले चलो', //9
        'मुझे क्विज पर ले चलो', //10
        'मुझे क्लास पर ले चलो', //11
        'मुझे रिसोर्सेज पर ले चलो', //12
        'मुझे प्रोग्रेस कार्ड पर ले चलो', //13
        'मुझे प्रोफ़ाइल पर ले चलो', //14
        'विकल्प 1 चुनें', //15
        'विकल्प 2 चुनें', //16
        'विकल्प 3 चुनें', //17
        'विकल्प 4 चुनें',
        'अगले प्रश्न पर जाएं',
        'पिछले प्रश्न पर जाएं',
        'मुझे लॉगिन स्क्रीन पर ले चलो',
        'my class code is',
        "यह कौन सा पेज है",
        "पेज का नाम",
        "मेरे लिए प्रश्न पढ़ें",
        "मेरे लिए विकल्प पढ़ें",
        "फ़ॉन्ट का आकार बढ़ाएँ",
        "फ़ॉन्ट का आकार घटाएं",
        "डार्क मोड टॉगल करें",
        "भाषा बदलें",
        null
      ];
      final bestMatch = text.bestMatch(targetStrings);

      switch (bestMatch.bestMatchIndex) {
        case 0:
          {
            text =
                text.substring(targetStrings[bestMatch.bestMatchIndex]!.length);
            var text1 = await translator.translate(text, from: 'hi', to: 'en');
            setText(logInUserIdController, text1.text.toLowerCase().trim());
            break;
          }
        case 1:
          {
            text =
                text.substring(targetStrings[bestMatch.bestMatchIndex]!.length);
            var text1 = await translator.translate(text, from: 'hi', to: 'en');
            setText(logInUserIdController, text1.text.toLowerCase().trim());
            break;
          }
        case 7:
          {
            if (navigatorKey.currentState!.canPop()) {
              navigatorKey.currentState!.pop();
            }
            break;
          }
        case 8:
          {
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(0);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
            }

            await _speak("हम आपको होमपेज पर ले जा रहे हैं");
            break;
          }
        case 9:
          {
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(1);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(1);
            }

            await _speak("हम आपको टेस्टस्क्रीन पर ले जा रहे हैं");
            break;
          }
        case 10:
          {
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: ((context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => QuizData()),
                        ChangeNotifierProvider(
                            create: (context) => TimerData()),
                      ],
                      child: const QuizQues(),
                    ))));
            await _speak("हम आपको क्विज़ पर ले जा रहे हैं");
            break;
          }
        case 11:
          {
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(0);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(0);
            }

            await _speak("हम आपको कक्षा में ले जा रहे हैं");
            break;
          }
        case 12:
          {
            // navigatorKey.currentState!.pushNamed(Resources.name);
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(2);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(2);
            }
            await _speak("हम आपको रिसोर्सेज में ले जा रहे हैं");
            break;
          }
        case 13:
          {
            navigatorKey.currentState!.pushNamed(Progresscard.name);

            await _speak("हम आपको प्रोग्रेस कार्ड में ले जा रहे हैं");
            break;
          }
        case 14:
          {
            // navigatorKey.currentState!.pushNamed(Progresscard.name);
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(3);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(3);
            }
            await _speak("आपको प्रोफ़ाइल टैब पर ले जा रहे हैं");
            break;
          }
        case 15:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(0);

            break;
          }
        case 16:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(1);

            break;
          }
        case 17:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(2);

            break;
          }
        case 18:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(3);

            break;
          }
        case 19:
          {
            Provider.of<QuizData>(context, listen: false).nextQuestion();

            break;
          }
        case 20:
          {
            Provider.of<QuizData>(context, listen: false).prevQuestion();

            break;
          }
        case 21:
          {
            navigatorKey.currentState!.pushNamed(LoginScreen.name);
            speak('हम आपको लॉगिन स्क्रीन पर ले जा रहे हैं');
            break;
          }
        case 22:
          {
            text = text.substring(16).trim();
            setText(homeClassCodeController, text);
            break;
          }
        case 23:
          {
            speak("आप अभी $currentscreen पर हैं");
            break;
          }
        case 24:
          {
            speak("आप अभी $currentscreen पर हैं");
            break;
          }
        case 25:
          {
            Provider.of<QuizData>(context, listen: false).readQuestion();
            break;
          }
        case 26:
          {
            await Provider.of<QuizData>(context, listen: false).readOptions();
            break;
          }
        case 27:
          {
            var provider = Provider.of<UserAppData>(context, listen: false);
            if (provider.font == CustomFont.small) {
              provider.setFont(CustomFont.medium);
            } else if (provider.font == CustomFont.medium) {
              provider.setFont(CustomFont.large);
            }
            break;
          }
        case 28:
          {
            var provider = Provider.of<UserAppData>(context, listen: false);
            if (provider.font == CustomFont.large) {
              provider.setFont(CustomFont.medium);
            } else if (provider.font == CustomFont.medium) {
              provider.setFont(CustomFont.small);
            }
            break;
          }
        case 29:
          {
            var isDarkMode =
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
            Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(!isDarkMode);
            break;
          }
        case 30:
          {
            final langProvider =
                Provider.of<LocaleProvider>(context, listen: false);
            bool isEnglish = langProvider.locale == Locale('en');
            isEnglish
                ? langProvider.setLocale(Locale('hi'))
                : langProvider.setLocale(Locale('en'));
          }
      }
      setState(() {
        text = "";
        _speechToText.stop();
        isListening = false;
      });
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
        'take me to profile',
        'mark option 1',
        'mark option two',
        'mark option 3',
        'mark option 4',
        'go to next question',
        'go to previous question',
        'take me to login screen',
        'my class code is',
        "which page is this",
        "page name",
        "read me the question",
        "read me the options",
        "increase font size",
        "decrease font size",
        "toggle dark mode",
        "change language",
        null
      ];
      final bestMatch = text1.bestMatch(targetStrings);

      switch (bestMatch.bestMatchIndex) {
        case 0:
          {
            text = text.substring(14);
            setText(logInUserIdController, text.toLowerCase());
            break;
          }
        case 1:
          {
            text = text.substring(14);
            if (currentscreen == LoginScreen.name) {
              setText(logInPasswordController, text.trim());
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
            if (navigatorKey.currentState!.canPop()) {
              navigatorKey.currentState!.pop();
              await _speak("Going back");
            } else {
              await _speak("Can't go back");
            }

            break;
          }
        case 7:
          {
            // navigatorKey.currentState!.pushNamed(HomeScreen.name);
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(0);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
            }

            await _speak("Taking you to homepage");
            break;
          }
        case 8:
          {
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(1);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(1);
            }

            await _speak("Taking you to testscreen");
            break;
          }
        case 9:
          {
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: ((context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => QuizData()),
                        ChangeNotifierProvider(
                            create: (context) => TimerData()),
                      ],
                      child: const QuizQues(),
                    ))));
            await _speak("Taking you to quiz");
            break;
          }
        case 10:
          {
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(0);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(0);
            }

            await _speak("Taking you to class");
            break;
          }
        case 11:
          {
            // navigatorKey.currentState!.pushNamed(Resources.name);
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(2);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(2);
            }
            await _speak("Taking you to resources");
            break;
          }
        case 12:
          {
            navigatorKey.currentState!.pushNamed(Progresscard.name);

            await _speak("Taking you to progress card");
            break;
          }
        case 13:
          {
            // navigatorKey.currentState!.pushNamed(Progresscard.name);
            if (currentscreen == HomeScreen.name) {
              Provider.of<UserAppData>(context, listen: false).setTabIndex(3);
            } else {
              navigatorKey.currentState!.pushNamed(HomeScreen.name);
              Provider.of<UserAppData>(context, listen: false).setTabIndex(3);
            }
            await _speak("Taking you to profile tab");
            break;
          }
        case 14:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(0);

            break;
          }
        case 15:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(1);

            break;
          }
        case 16:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(2);

            break;
          }
        case 17:
          {
            Provider.of<QuizData>(context, listen: false).markAnswer(3);

            break;
          }
        case 18:
          {
            Provider.of<QuizData>(context, listen: false).nextQuestion();

            break;
          }
        case 19:
          {
            Provider.of<QuizData>(context, listen: false).prevQuestion();

            break;
          }
        case 20:
          {
            navigatorKey.currentState!.pushNamed(LoginScreen.name);
            speak('Taking you to login screen');
            break;
          }
        case 21:
          {
            text = text.substring(16).trim();
            setText(homeClassCodeController, text);
            break;
          }
        case 22:
          {
            speak("You are currently on $currentscreen");
            break;
          }
        case 23:
          {
            speak("You are currently on $currentscreen");
            break;
          }
        case 24:
          {
            Provider.of<QuizData>(context, listen: false).readQuestion();
            break;
          }
        case 25:
          {
            await Provider.of<QuizData>(context, listen: false).readOptions();
            break;
          }
        case 26:
          {
            var provider = Provider.of<UserAppData>(context, listen: false);
            if (provider.font == CustomFont.small) {
              provider.setFont(CustomFont.medium);
            } else if (provider.font == CustomFont.medium) {
              provider.setFont(CustomFont.large);
            }
            break;
          }
        case 27:
          {
            var provider = Provider.of<UserAppData>(context, listen: false);
            if (provider.font == CustomFont.large) {
              provider.setFont(CustomFont.medium);
            } else if (provider.font == CustomFont.medium) {
              provider.setFont(CustomFont.small);
            }
            break;
          }
        case 28:
          {
            var isDarkMode =
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
            Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(!isDarkMode);
            break;
          }
        case 29:
          {
            final langProvider =
                Provider.of<LocaleProvider>(context, listen: false);
            bool isEnglish = langProvider.locale == Locale('en');
            isEnglish
                ? langProvider.setLocale(Locale('hi'))
                : langProvider.setLocale(Locale('en'));
          }
      }

      if (mounted) {
        setState(() {
          text = "";
          _speechToText.stop();
          isListening = false;
        });
      }
    }

    List<LocaleName> _localeNames = [];
    LocaleName? localeName;

    void listen() async {
      var prov = Provider.of<LocaleProvider>(context, listen: false);
      bool isEnglish = prov.locale == Locale('en');
      if (!isListening) {
        bool available = await _speechToText.initialize(
            onStatus: (val) {
              if (val == "done") {}
              print('$val');
            },
            onError: (val) => print('onError: $val'),
            debugLogging: true);

        if (available) {
          _localeNames = await _speechToText.locales();
          _localeNames.forEach((element) {
            print(element.localeId);
            if (element.localeId == "hi_IN") {
              setState(() {
                localeName = element;
              });
            }
          });
          var systemLocale = await _speechToText.systemLocale();
          var _currentLocaleId = systemLocale!.localeId;
        }
        if (available) {
          if (mounted) {
            setState(() {
              isListening = true;
            });
          }
          var locales = await _speechToText.locales();
          //var selectedLocale = locales[]
          _speechToText.listen(
            localeId: !isEnglish ? localeName!.localeId : null,
            listenMode: ListenMode.deviceDefault,
            listenFor: Duration(seconds: 10),
            onResult: (val) {
              if (mounted) {
                setState(() {
                  text = val.recognizedWords;
                });
              }

              print(val.recognizedWords);
              // navigateToPage(text);
              if (val.finalResult) {
                isEnglish ? readCommand(text) : readCommandHindi(text);
              }

              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
            },
          );
        }
      } else {
        setState(() {
          isListening = false;
          _speechToText.stop();
        });
      }
    }

/* onLongPressed: () {

            _animationController.status == AnimationStatus.dismissed
                ? (_animationController).forward()
                : (_animationController).reverse();
            if (widget.toggleButtonOnPressed != null) {
              widget.toggleButtonOnPressed!();
            }
          },
          icon: null,
          margin: widget.toggleButtonMargin,
          color: widget.toggleButtonColor ?? Theme.of(context).primaryColor,
          padding: (-_animation.value * widget.toggleButtonPadding * 0.5) +
              widget.toggleButtonPadding,
          onTap: () {
            print("pressed0");
            if (_animationController.status != AnimationStatus.dismissed) {
              (_animationController).reverse();
            } else {



            listen();
            }
            */

    return Positioned.fill(
      child: Align(
        child: Stack(
          children: [
            Align(
              alignment: widget.alignment,
              child: Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Material(
                    color: Color(0xFF5BB92F),
                    child: InkWell(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: isListening
                                  ? Lottie.asset('assets/images/lottie.json',
                                      height: 100)
                                  : ImageIcon(
                                      AssetImage('assets/images/mic.png'),
                                      color: Colors.white,
                                      size: 30,
                                    ))),
                      onTap: () {
                        listen();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 75,
              right: 100,
              child: AnimatedContainer(
                padding: const EdgeInsets.all(5),
                duration: Duration(milliseconds: 500),
                constraints: BoxConstraints(minWidth: 0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: Colors.black),
                ),
                decoration: BoxDecoration(
                    color: text.length > 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.backgroundWidget ?? Container(),
        ..._buildMenuItems(),
        _buildMenuButton(context),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
