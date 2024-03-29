import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/theme_provider.dart';

class TestCards extends StatelessWidget {
  String courseCode;
  String chapter;
  String date;
  String time;
  String faculty;
  int maxMarks;

  TestCards({
    required this.courseCode,
    required this.chapter,
    required this.date,
    required this.time,
    required this.faculty,
    required this.maxMarks,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 1,
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
              color: isDarkMode ? Color(0xffA9A9A9) : Color(0xff555555),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              text: "Teacher: ",
              style: GoogleFonts.sourceSansPro(
                color: isDarkMode ? Color(0xffA9A9A9) : Color(0xff2F2F2F),
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: faculty,
                  style: GoogleFonts.sourceSansPro(
                    color: isDarkMode ? Color(0xffA9A9A9) : Color(0xff2F2F2F),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Max Marks: ",
              style: GoogleFonts.sourceSansPro(
                color: isDarkMode ? Color(0xffA9A9A9) : Color(0xff2F2F2F),
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: maxMarks.toString(),
                  style: GoogleFonts.sourceSansPro(
                    color: isDarkMode ? Color(0xffA9A9A9) : Color(0xff2F2F2F),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
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
                      color: isDarkMode ? Color(0xffA9A9A9) :  Color(0xff2F2F2F),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
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
                      color: isDarkMode ? Color(0xffA9A9A9) :  Color(0xff2F2F2F),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
