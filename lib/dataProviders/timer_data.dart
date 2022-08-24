import 'dart:async';

import 'package:educazy/data/quiz_data.dart';
import 'package:flutter/cupertino.dart';

class TimerData extends ChangeNotifier {
  Timer? countDownTimer;
  Duration? myDuration = quizData.duration;

  Duration getRemainingTime() => myDuration!;

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
    myDuration = duration;
    notifyListeners();
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = myDuration!.inSeconds - reduceSecondsBy;

    seconds < 0
        ? countDownTimer!.cancel()
        : myDuration = Duration(seconds: seconds);
    print(myDuration);
    notifyListeners();
  }
}
