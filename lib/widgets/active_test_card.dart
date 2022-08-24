import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dataProviders/quiz_data_provider.dart';
import '../dataProviders/timer_data.dart';
import '../screens/quiz_screens/quiz_ques.dart';


class ActiveTestCard extends StatelessWidget {
  String courseCode;
  String chapter;
  String date;
  String time;
  String faculty;
  int maxMarks;
  double width;

  ActiveTestCard({
    required this.courseCode,
    required this.chapter,
    required this.date,
    required this.time,
    required this.faculty,
    required this.maxMarks,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseCode,
            style: GoogleFonts.sourceSansPro(
              color: Color(0xff107ABE),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            chapter,
            style: GoogleFonts.sourceSansPro(
              fontSize: 14,
              color: Color(0xff555555),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              text: "Teacher: ",
              style: GoogleFonts.sourceSansPro(
                color: Color(0xff2F2F2F),
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: faculty,
                  style: GoogleFonts.sourceSansPro(
                    color: Color(0xff2F2F2F),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xff8F8F8F),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: GoogleFonts.sourceSansPro(
                      color: const Color(0xff2F2F2F),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Color(0xff8F8F8F),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: GoogleFonts.sourceSansPro(
                      color: const Color(0xff2F2F2F),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.done_outline,
                    color: Color(0xff8F8F8F),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    maxMarks.toString() + " Marks",
                    style: GoogleFonts.sourceSansPro(
                      color: const Color(0xff2F2F2F),
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => QuizData()),
                          ChangeNotifierProvider(
                              create: (context) => TimerData()),
                        ],
                        child: const QuizQues(),
                      )),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: width,
              child: Text(
                "START TEST",
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
              // width: double.in
              decoration: const BoxDecoration(
                color: Color(0xff55AD2C),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
