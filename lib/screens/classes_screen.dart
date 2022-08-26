import 'package:educazy/screens/enrolled_class_screen.dart';
import 'package:educazy/utils/custom_colors.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final homeClassCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
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
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Enrolled Classes',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: isDarkMode ? Color(0xffA9A9A9) : Color(0xFF555555),
                  ),
                ),
                const SizedBox(height: 13),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => EnrolledScreen()),
                      ),
                    );
                  },
                  child: EnrolledClass(
                    width: width,
                    facultyName: 'Mr. Vedant Singh',
                    subjectName: 'Social Studies',
                    onPressed: () {},
                    image: Icon(
                      Entypo.globe,
                      color: CustomColors.green,
                      size: 24,
                    ),
                    primaryColor: const Color(0XFF1D934C),
                    backColor: const Color(0xFF1D934C).withOpacity(0.05),
                  ),
                ),
                EnrolledClass(
                  width: width,
                  facultyName: 'Mr. Viraj',
                  subjectName: 'Mathematics',
                  onPressed: () {},
                  image: const Icon(
                    Icons.calculate_outlined,
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
                  image: const Icon(
                    Icons.science,
                    color: Color(0xFF914698),
                    size: 24,
                  ),
                  primaryColor: Color(0xFF914698),
                  backColor: Color(0xFF914698).withOpacity(0.05),
                ),
              ],
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backColor),
                    child: Center(child: image),
                  ),
                  const SizedBox(width: 21),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          subjectName,
                          style: GoogleFonts.sourceSansPro(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 7),
                        CustomText(
                          'by $facultyName',
                          style: GoogleFonts.sourceSansPro(
                              color: Color(0xFF777777), fontSize: 13),
                        )
                      ])
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: isDarkMode ? Color(0xFF1B1B1B) : Color(0xFFF1F1F1)),
              child: const Center(
                child: Icon(
                  Icons.navigate_next_rounded,
                  color: Color(0xFf999999),
                ),
              ),
            ),
          ],
        ),
      ),
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(16),
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
          //           CustomText(
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
          //               child: CustomText(
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 44,
            width: widget.width,
            child: Row(
              children: [
                Container(
                  width: 0.67 * widget.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      border: Border.all(
                          color: const Color(0xFF000000).withOpacity(0.10),
                          width: 1.0),
                      color: isDarkMode
                          ? CustomColors.textFieldDark
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
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        fillColor: isDarkMode
                            ? CustomColors.textFieldDark
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
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(
                          color: const Color(0xFF000000).withOpacity(0.10),
                          width: 1.0),
                      color: buttonColor,
                    ),
                    child: Center(
                      child: CustomText('Join Class',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 16,
                              color: !isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF0D0D0D),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
