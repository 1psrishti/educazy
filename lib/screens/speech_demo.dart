import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechDemo extends StatefulWidget {
  const SpeechDemo({Key? key}) : super(key: key);

  @override
  State<SpeechDemo> createState() => _SpeechDemoState();
}

class _SpeechDemoState extends State<SpeechDemo> {
  SpeechToText? _speechToText;
  bool _isListening = false;
  String _text = "";
  double _confidence = 1.0;
  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
  }

  Widget? _renderWidget = null;
  @override
  Widget build(BuildContext context) {
    void _listen() async {
      if (!_isListening) {
        bool available = await _speechToText!.initialize(
            onStatus: (val) => print('onStatus: $val'),
            onError: (val) => print('onError: $val'),
            debugLogging: true);
        if (available) {
          setState(() => _isListening = true);
          _speechToText!.listen(
            listenMode: ListenMode.deviceDefault,
            listenFor: Duration(seconds: 10),
            onResult: (val) => setState(() {
              print(val.recognizedWords);
              _text = val.recognizedWords;
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

    return Scaffold(
        appBar: AppBar(
            title:
                Text('Confidence: ${(_confidence * 100).toStringAsFixed(1)}%')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            _listen();
          }),
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 150),
              child: Text(
                _text,
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              )),
        ));
  }
}
