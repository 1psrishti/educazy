import 'package:educazy/models/user_model.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/student_data.dart';

class Progresscard extends StatefulWidget {
  static const name = 'progresscard';
  const Progresscard({Key? key}) : super(key: key);

  @override
  State<Progresscard> createState() => _ProgresscardState();
}

class _ProgresscardState extends State<Progresscard> {
  UserModel student = student1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUsers();
  }

  setUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel us = UserModel.fromJson(prefs.getString('userdata')!);
    print(us.toJson());
    setState(() {
      student = us;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 27,
                      ),
                      CustomText(
                        'Progress Card',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Color(0xFF3D3D3D)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      CustomText(
                        'One-Portal-One-Report-Card',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xFF3D3D3D)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      CustomText(
                        'Never stop learning! Books, worksheets and reading materials now just one click away.',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: const Color(0xFF5E5D5D)),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 58),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(color: Color(0xFFDDDDDD), width: 1),
                            boxShadow: [
                              const BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 25,
                                color: Color.fromRGBO(0, 0, 0, 0.08),
                              )
                            ]),
                        child: Center(
                            child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 24),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/photo.png'),
                                        radius: 32,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText('UUID: ${student.userId}',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          CustomText('Name: ${student.name}',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 18),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          CustomText(
                                            'Class: ${student.className}',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                            textAlign: TextAlign.left,
                                          ),
                                          CustomText(
                                            'School: ${student.school}',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                            textAlign: TextAlign.left,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: Color(0xFFF4F4F4),
                              ),
                              child: CustomText(
                                'Normalised Marks',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF202020),
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            student.marksList![index].subject
                                                .name.name,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Color(0xFF202020)),
                                          ),
                                          CustomText(
                                            '${student.marksList![index].acquiredMarks}/${student.marksList![index].totalMarks}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Color(0xFF2D66D6)),
                                          )
                                        ],
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 2.0,
                                  );
                                },
                                itemCount: student.marksList!.length)
                          ],
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: RichText(
                            text: TextSpan(
                                text: 'Normalized Marks',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Color(0xFF202020)),
                                children: [
                              TextSpan(
                                  text:
                                      ' means the marks have been adjusted by taking multiple factors into consideration for specific students.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Color(0xFF5E5D5D),
                                      letterSpacing: 1.0))
                            ])),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
