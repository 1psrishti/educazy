import 'package:educazy/utils/custom_colors.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/toggle_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/screen_wrapper.dart';
import 'home_screen.dart';

class Classes extends StatefulWidget {
  const Classes({Key? key}) : super(key: key);

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  final homeClassCodeController = TextEditingController();
  bool? isDarkMode;
  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    double width = MediaQuery.of(context).size.width - 40;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopSection(
            notifNo: notifNo,
            width: width,
            controller: homeClassCodeController,
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enrolled Classes',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF555555)),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  EnrolledClass(
                    width: width,
                    facultyName: 'Mr. Vedant Singh',
                    subjectName: 'Social Studies',
                    onPressed: () {},
                    image: Icon(
                      Entypo.globe,
                      color: CustomColors.green,
                      size: 24,
                    ),
                    primaryColor: Color(0XFF1D934C),
                    backColor: Color(0xFF1D934C).withOpacity(0.05),
                  ),
                  EnrolledClass(
                    width: width,
                    facultyName: 'Mr. Viraj',
                    subjectName: 'Mathematics',
                    onPressed: () {},
                    image: ImageIcon(
                      AssetImage('assets/images/math.png'),
                      color: Color(0xFf107ABE),
                      size: 24,
                    ),
                    primaryColor: Color(0xFf107ABE),
                    backColor: Color(0xFf107ABE).withOpacity(0.05),
                  ),
                  EnrolledClass(
                    width: width,
                    facultyName: 'Ms. Srishti',
                    subjectName: 'Science',
                    onPressed: () {},
                    image: ImageIcon(
                      AssetImage('assets/images/science.png'),
                      color: Color(0xFF914698),
                      size: 24,
                    ),
                    primaryColor: Color(0xFF914698),
                    backColor: Color(0xFF914698).withOpacity(0.05),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnrolledClass extends StatelessWidget {
  const EnrolledClass({
    Key? key,
    required this.width,
    required this.onPressed,
    required this.subjectName,
    required this.facultyName,
    required this.image,
    required this.backColor,
    required this.primaryColor,
  }) : super(key: key);

  final double width;
  final void Function() onPressed;
  final String subjectName;
  final String facultyName;
  final Widget image;
  final Color backColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 21),
      height: 100,
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Color.fromARGB(255, 255, 255, 255).withOpacity(0.08)
                  : Color(0xFF000000).withOpacity(0.08),
              offset: Offset(0, 4),
              blurRadius: 8,
              blurStyle: BlurStyle.normal,
            )
          ]),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backColor),
                  child: Center(child: image),
                ),
                SizedBox(
                  width: 21,
                ),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          subjectName,
                          style: GoogleFonts.sourceSansPro(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'by $facultyName',
                          style: GoogleFonts.sourceSansPro(
                              color: Color(0xFF777777), fontSize: 13),
                        )
                      ]),
                )
              ],
            ),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: isDarkMode ? Color(0xFF1B1B1B) : Color(0xFFF1F1F1)),
            child: Center(
                child: ImageIcon(
              AssetImage('assets/images/next.png'),
              color: Color(0xFf999999),
            )),
          )
        ],
      )),
    );
  }
}

class TopSection extends StatefulWidget {
  const TopSection({
    Key? key,
    required this.notifNo,
    required this.width,
    required this.controller,
  }) : super(key: key);

  final int notifNo;
  final double width;
  final TextEditingController controller;

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  Color? buttonColor;
  bool buttonDisabled = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        buttonColor = Theme.of(context).disabledColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 22),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       child: Row(
          //         children: [
          //           ImageIcon(
          //             AssetImage('assets/images/logo1.png'),
          //             color: CustomColors.blue,
          //             size: 33,
          //           ),
          //           SizedBox(
          //             width: 18,
          //           ),
          //           Text(
          //             'Educazy',
          //             style: GoogleFonts.squadaOne(
          //                 fontSize: 21, color: CustomColors.blue),
          //           )
          //         ],
          //       ),
          //     ),
          //     Container(
          //       child: Row(
          //         children: [
          //           Container(
          //             height: 40,
          //             width: 40,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color: CustomColors.blue.withOpacity(0.05)),
          //             child: Center(
          //                 child: ImageIcon(
          //               AssetImage('assets/images/help-circle.png'),
          //               color: CustomColors.blue,
          //               size: 25,
          //             )),
          //           ),
          //           const SizedBox(
          //             width: 26,
          //           ),
          //           Badge(
          //             badgeColor: const Color(0xFFD84F4F),
          //             badgeContent: Padding(
          //               padding: const EdgeInsets.all(2.0),
          //               child: Text(
          //                 widget.notifNo.toString(),
          //                 style: const TextStyle(
          //                     color: Colors.white, fontSize: 10),
          //               ),
          //             ),
          //             toAnimate: true,
          //             position: BadgePosition.topEnd(end: 0),
          //             child: Container(
          //               height: 40,
          //               width: 40,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   color: CustomColors.blue.withOpacity(0.05)),
          //               child: Center(
          //                   child: ImageIcon(
          //                 AssetImage('assets/images/bell.png'),
          //                 color: CustomColors.blue,
          //                 size: 25,
          //               )),
          //             ),
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),

          Container(
            height: 44,
            width: widget.width,
            child: Row(children: [
              Container(
                width: 0.67 * widget.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    border: Border.all(
                        color: Color(0xFF000000).withOpacity(0.10), width: 1.0),
                    color: isDarkMode
                        ? CustomColors.textfieldDark
                        : CustomColors.lightGrey),
                child: TextField(
                  onChanged: (value) {
                    if (value.length > 3) {
                      setState(() {
                        buttonColor = isDarkMode
                            ? CustomColors.button
                            : CustomColors.buttonDark;
                        buttonDisabled = false;
                      });
                    } else {
                      setState(() {
                        buttonColor = Theme.of(context).disabledColor;
                        buttonDisabled = true;
                      });
                    }
                  },
                  controller: widget.controller,
                  decoration: InputDecoration(
                      hintText: '#Class ID',
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: isDarkMode
                          ? CustomColors.textfieldDark
                          : CustomColors.lightGrey,
                      hintStyle: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: CustomColors.hintColor)),
                ),
              ),
              InkWell(
                onTap: !buttonDisabled ? () {} : null,
                child: Container(
                    width: 0.33 * widget.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(
                          color: Color(0xFF000000).withOpacity(0.10),
                          width: 1.0),
                      color: buttonColor,
                    ),
                    child: Center(
                      child: Text('Join Class',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 16,
                              color: !isDarkMode
                                  ? Colors.white
                                  : Color(0xFF0D0D0D),
                              fontWeight: FontWeight.w600)),
                    )),
              )
            ]),
          )
        ],
      ),
    );
  }
}
