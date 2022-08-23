import 'dart:async';

import 'package:educazy/data/quiz_data.dart';
import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/models/question_model.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../HelperMethods/helper_methods.dart';

class QuizQues extends StatefulWidget {
  static const name = 'quizscreen';
  const QuizQues({Key? key}) : super(key: key);

  @override
  State<QuizQues> createState() => _QuizQuesState();
}

class _QuizQuesState extends State<QuizQues> {
  int _currentQuestionIndex = 0;
  String? _markedAnswer;
  Question? currentQues;

  Timer? countDownTimer;
  Duration? testDuration;

  int? _groupValue;

  QuizData? quizProvider;
  TimerData? timerProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    testDuration = quizData.duration;
    quizProvider = Provider.of<QuizData>(context, listen: false);
    timerProvider = Provider.of<TimerData>(context, listen: false);

    _groupValue = _currentQuestionIndex;
    startTimer();
  }

  void _nextQuestion() {
    if (quizData.questions.length > _currentQuestionIndex + 1) {
      setState(() {
        _currentQuestionIndex = _currentQuestionIndex + 1;
      });
    } else {}
  }

  void _prevQuestion() {
    if (_currentQuestionIndex - 1 >= 0) {
      setState(() {
        _currentQuestionIndex = _currentQuestionIndex - 1;
      });
    }
  }

  void markAnswer(String answer) {
    Question currentQues = quizData.questions[_currentQuestionIndex];
    if (currentQues.answers.contains(answer)) {
      setState(() {
        currentQues.markedAnswer = answer;
      });
    }
  }

  void onchangedAnswer(val) {
    setState(() {
      _groupValue = val;
    });
    quizProvider!.markAnswer(currentQues!.answers[val]);
  }

  void startTimer() {
    countDownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setCountDown();
    });
  }

  void stopTimer() {
    countDownTimer!.cancel();
  }

  void resetTimer(Duration duration) {
    stopTimer();
    setState(() {
      testDuration = duration;
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = testDuration!.inSeconds - reduceSecondsBy;

    setState(() {
      seconds < 0
          ? countDownTimer!.cancel()
          : testDuration = Duration(seconds: seconds);
      print(testDuration);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    var textColor = isDarkMode ? Color(0xFFDFDFDF) : Color(0xFF202020);
    currentQues = quizData.questions[_currentQuestionIndex];
    final width = MediaQuery.of(context).size.width;
    return ScreenWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Test - ${quizData.name} (${quizData.id})',
                      style: GoogleFonts.poppins(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 19, vertical: 13),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: 0.915 * width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Fontisto.clock,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Time Remaining',
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text(HelperMethods.printDuration(testDuration!),
                              style: GoogleFonts.poppins(color: Colors.black))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: Text(
                        'Question ${_currentQuestionIndex + 1}',
                        style: GoogleFonts.poppins(color: Color(0xFF707070)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 9),
                      child: Text(
                        currentQues!.question,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentQues!.answers.length,
                        itemBuilder: (context, index) {
                          print(_groupValue);
                          return GestureDetector(
                            onTap: () {
                              onchangedAnswer(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: isDarkMode
                                    ? Color(0xFF181818)
                                    : const Color(0xFFF3F3F3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: index,
                                      groupValue: _groupValue,
                                      onChanged: onchangedAnswer),
                                  Text('${String.fromCharCode(65 + index)})'),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(currentQues!.answers[index])
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _prevQuestion();
                          },
                          child: Row(children: [
                            Icon(
                              Entypo.chevron_small_left,
                              color: Theme.of(context).primaryColor,
                              size: 21,
                            ),
                            Text('Previous',
                                // gradient: const LinearGradient(
                                //   colors: [
                                //     Color(0xFF8A5BEF),
                                //     Color(0xFF5866DE)
                                //   ],
                                // ),
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18))
                          ]),
                        ),
                        TextButton(
                          onPressed: () {
                            print("next");
                            _nextQuestion();
                          },
                          child: Row(children: [
                            Text('Next',
                                // gradient: const LinearGradient(
                                //   colors: [
                                //     Color(0xFF8A5BEF),
                                //     Color(0xFF5866DE)
                                //   ],
                                // ),
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18)),
                            Icon(
                              Entypo.chevron_small_right,
                              color: Theme.of(context).primaryColor,
                              size: 21,
                            ),
                          ]),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
