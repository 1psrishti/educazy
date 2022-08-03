import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/helper_methods.dart';
import 'package:educazy/screens/progress_card.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:educazy/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/image.png'),
                    const SizedBox(height: 34),
                    const Text(
                      "Join the Class",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Explore, question, learn. Connect virtually with the "
                      "guided support of sign language detection and "
                      "subtitles.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xffAEAEAE),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter code - Excyyz-99990",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Color(0xff8D8D8D),
                            ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xffEDEDED),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "Join Class",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xff62C733),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tabs(
                                onPressed: (() {}),
                                imagePath: "assets/images/classes.png",
                                text: "Join\nClasses"),
                            Tabs(
                                onPressed: () {
                                  HelperMethods.navigateTo(
                                      MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider(
                                                create: (context) => QuizData()),
                                            ChangeNotifierProvider(
                                                create: (context) => TimerData()),
                                          ],
                                          child: const QuizQues(),
                                      ), context
                                  );
                                },
                                imagePath: "assets/images/tests.png",
                                text: "Tests"),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tabs(
                                onPressed: () {
                                  HelperMethods.navigateTo(const Progresscard(), context);
                                },
                                imagePath: "assets/images/progress_cards.png",
                                text: "Progress\nCard"),
                            Tabs(
                                onPressed: () {
                                  HelperMethods.navigateTo(
                                      const Resources(), context);
                                },
                                imagePath: "assets/images/resources.png",
                                text: "Resources"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              const HeaderText(text: "Events"),
              const SizedBox(height: 10),
              const TaglineText(text: "Upcoming events conducted for you. Find new doors of opportunities."),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset('assets/images/img1.png'),
                    const SizedBox(width: 10),
                    Image.asset('assets/images/img2.png'),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const HeaderText(text: "Schedule"),
              const SizedBox(height: 10),
              const TaglineText(text: "Find your plans for the day."),
              const SizedBox(height: 30),
              Cards(
                titleText: "Maternal Science Class",
                date: "5 Aug 2022",
                time: "9:30 AM to 10:30 AM",
                text: "Session 3 - Topics covered : Decimal expressions, "
                    "terminating and non terminating rational numbers.",
              ),
              const SizedBox(height: 16),
              Cards(
                titleText: "Maternal Science Class",
                date: "5 Aug 2022",
                time: "9:30 AM to 10:30 AM",
                text: "Session 3 - Topics covered : Decimal expressions, "
                    "terminating and non terminating rational numbers.",
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      )),
    );
  }
}
