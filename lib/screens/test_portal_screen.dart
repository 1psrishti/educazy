import 'package:educazy/constants.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dataProviders/quiz_data_provider.dart';
import '../dataProviders/timer_data.dart';
import '../helper_methods.dart';
import '../widgets/header_logo.dart';
import '../widgets/text_styles.dart';
import '../widgets/widgets.dart';

class TestPortal extends StatefulWidget {
  const TestPortal({Key? key}) : super(key: key);

  @override
  State<TestPortal> createState() => _TestPortalState();
}

class _TestPortalState extends State<TestPortal> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ScreenWrapper(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderLogo(),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0613 * width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Test Portal",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const HeaderText(text: "Active Test"),
                            const SizedBox(height: 10),
                            TestCards(
                                titleText: "Ray Optics",
                                date: "04/08/22",
                                time: "9:30",
                                maxMarks: 75,
                                profName: "Mr. John Doe"),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => MultiProvider(
                                              providers: [
                                                ChangeNotifierProvider(
                                                    create: (context) =>
                                                        QuizData()),
                                                ChangeNotifierProvider(
                                                    create: (context) =>
                                                        TimerData()),
                                              ],
                                              child: const QuizQues(),
                                            ))));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 50),
                                child: const Text(
                                  "Give Test",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                // width: double.in
                                decoration: const BoxDecoration(
                                  color: Color(0xff62C733),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      const HeaderText(text: "Instructions"),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Icons.check_circle, color: Color(0xff27D381)),
                          SizedBox(width: 10),
                          Text(
                            "The paper contains 10 questions.",
                            style: TextStyle(
                              color: Color(0xffABABAB),
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.check_circle, color: Color(0xff27D381)),
                          SizedBox(width: 10),
                          Text(
                            "The paper will  close after 30 minutes.",
                            style: TextStyle(
                              color: Color(0xffABABAB),
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.check_circle, color: Color(0xff27D381)),
                          SizedBox(width: 10),
                          Text(
                            "Have a stable network connection.",
                            style: TextStyle(
                              color: Color(0xffABABAB),
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.check_circle, color: Color(0xff27D381)),
                          SizedBox(width: 10),
                          Text(
                            "Take the test in a closed room.",
                            style: TextStyle(
                              color: Color(0xffABABAB),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      const HeaderText(text: "Upcoming"),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              TestCards(
                                  titleText: "Ray Optics",
                                  date: "04/08/22",
                                  time: "9:30",
                                  maxMarks: 75,
                                  profName: "Mr. John Doe"),
                              const SizedBox(width: 20),
                              TestCards(
                                  titleText: "Ray Optics",
                                  date: "04/08/22",
                                  time: "9:30",
                                  maxMarks: 75,
                                  profName: "Mr. John Doe"),
                              const SizedBox(width: 20),
                              TestCards(
                                  titleText: "Ray Optics",
                                  date: "04/08/22",
                                  time: "9:30",
                                  maxMarks: 75,
                                  profName: "Mr. John Doe"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const HeaderText(text: "Previous"),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              TestCards(
                                  titleText: "Ray Optics",
                                  date: "04/08/22",
                                  time: "9:30",
                                  maxMarks: 75,
                                  profName: "Mr. John Doe"),
                              const SizedBox(width: 20),
                              TestCards(
                                  titleText: "Ray Optics",
                                  date: "04/08/22",
                                  time: "9:30",
                                  maxMarks: 75,
                                  profName: "Mr. John Doe"),
                              const SizedBox(width: 20),
                              TestCards(
                                  titleText: "Ray Optics",
                                  date: "04/08/22",
                                  time: "9:30",
                                  maxMarks: 75,
                                  profName: "Mr. John Doe"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
