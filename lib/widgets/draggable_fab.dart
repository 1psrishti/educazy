import 'dart:async';

import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/main.dart';
import 'package:educazy/screens/homescreen.dart';
import 'package:educazy/screens/progress_card.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DraggableFloatingActionButton extends StatefulWidget {
  final Offset initialOffset;
  final VoidCallback onPressed;
  final GlobalKey parentKey;

  DraggableFloatingActionButton(
      {required this.initialOffset,
      required this.onPressed,
      required this.parentKey});

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
    // TODO: implement dispose
    super.dispose();
    _speechToText!.stop();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText!.initialize(
          onStatus: (val) {
            if (val == "done") {}
            print('$val');
          },
          onError: (val) => print('onError: $val'),
          debugLogging: true);
      if (available) {
        setState(() => _isListening = true);
        _speechToText!.listen(
          listenMode: ListenMode.deviceDefault,
          listenFor: Duration(seconds: 10),
          onResult: (val) => setState(() async {
            _text = val.recognizedWords;
            print(val.recognizedWords);
            navigateToPage(_text);

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
    _offset = widget.initialOffset;
    _speechToText = SpeechToText();

    WidgetsBinding.instance.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
      });
    } catch (e) {
      print('catch: $e');
    }
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
              style: TextStyle(fontSize: 18),
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
          child: Listener(
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              _updatePosition(pointerMoveEvent);

              setState(() {
                _isDragging = true;
              });
            },
            onPointerUp: (PointerUpEvent pointerUpEvent) {
              print('onPointerUp');

              if (_isDragging) {
                setState(() {
                  _isDragging = false;
                });
              } else {
                _listen();
              }
            },
            child: Stack(
              children: [
                Container(
                  key: _key,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.yellow),
                    padding: EdgeInsets.all(20),
                    child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
}
