import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/test_cards.dart';
import '../widgets/active_test_card.dart';

class TestPortal extends StatefulWidget {
  static const String name = "testPortal";
  const TestPortal({Key? key}) : super(key: key);

  @override
  State<TestPortal> createState() => _TestPortalState();
}

class _TestPortalState extends State<TestPortal> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                width: double.infinity,
                color: const Color(0xff0A5580),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Active Test",
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    ActiveTestCard(
                      courseCode: "Physics (PY123978)",
                      chapter: "Ray Optics",
                      date: "24th Aug 2022",
                      time: "9:30 AM",
                      maxMarks: 75,
                      faculty: "Mr. Vedant Singh",
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CustomText(
                      "Upcoming Tests",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: Color(0xff555555),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            TestCards(
                              courseCode: "English (ENG3978)",
                              chapter: "Literature",
                              date: "30th Aug 2022",
                              time: "9:30 AM",
                              maxMarks: 75,
                              faculty: "Mr. Viraj",
                            ),
                            const SizedBox(width: 16),
                            TestCards(
                              courseCode: "English (ENG3978)",
                              chapter: "Literature",
                              date: "30th Aug 2022",
                              time: "9:30 AM",
                              maxMarks: 75,
                              faculty: "Mr. Viraj",
                            ),
                            const SizedBox(width: 16),
                            TestCards(
                              courseCode: "English (ENG3978)",
                              chapter: "Literature",
                              date: "30th Aug 2022",
                              time: "9:30 AM",
                              maxMarks: 75,
                              faculty: "Mr. Viraj",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Color(0xff107ABE),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            "Results & Previous Tests",
                            style: GoogleFonts.sourceSansPro(
                              color: Color(0xff107ABE),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            // height: 30,
                            // width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color:
                                    const Color(0xFF107ABE).withOpacity(0.1)),
                            child: const Center(
                              child: Icon(
                                Icons.navigate_next_rounded,
                                color: Color(0xff107ABE),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
