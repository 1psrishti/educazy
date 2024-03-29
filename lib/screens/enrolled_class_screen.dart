import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EnrolledScreen extends StatefulWidget {
  final String subjectName;
  final String facultyName;
  final String description;
  final String image;

  const EnrolledScreen(
      {Key? key,
      required this.subjectName,
      required this.facultyName,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  State<EnrolledScreen> createState() => _EnrolledScreenState();
}

class _EnrolledScreenState extends State<EnrolledScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: false,
          pinned: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ), //Images.network
          ),
          expandedHeight: 190,
          leading: Container(
              width: 36,
              height: 36,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: BackButton()),
        ), //SliverAppBar

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  CustomText(
                    widget.subjectName,
                    style: GoogleFonts.sourceSansPro(
                      color: Color(0xff2F2F2F),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomText(
                    widget.subjectName,
                    style: GoogleFonts.sourceSansPro(fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  CustomText(
                    widget.facultyName,
                    style: GoogleFonts.sourceSansPro(
                      color: Color(0xff777777),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(24),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF7F7F7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          AppLocalizations.of(context)!.classes,
                          style: GoogleFonts.sourceSansPro(
                            color: Color(0xff555555),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    "Mon, 2:00PM to 2:50 PM",
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 14,
                                      color: Color(0xff2F2F2F),
                                    ),
                                  ),
                                  CustomText(
                                    "Wed, 11:00 AM to 1:50 PM",
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 14,
                                      color: Color(0xff2F2F2F),
                                    ),
                                  ),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () {},
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff55AD2C),
                                  ),
                                  child: CustomText(
                                    AppLocalizations.of(context)!.join_class,
                                    style: GoogleFonts.sourceSansPro(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        width: width / 2 - 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffFC605D).withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppLocalizations.of(context)!.resources,
                              style: GoogleFonts.sourceSansPro(
                                color: Color(0xffC53835),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Image.asset("assets/images/resources.png"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(24),
                        width: width / 2 - 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffFAA231).withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppLocalizations.of(context)!.tests,
                              style: GoogleFonts.sourceSansPro(
                                color: Color(0xffFAA231),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Image.asset("assets/images/resources.png"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomText(
                    AppLocalizations.of(context)!.notice_board,
                    style: GoogleFonts.sourceSansPro(
                      color: Color(0xff555555),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child:
                                        Image.asset("assets/images/photo.png"),
                                    radius: 18,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomText(
                                    "Vedant Singh",
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              CustomText(
                                "24 Aug, 10:45 AM",
                                style: GoogleFonts.sourceSansPro(
                                  color: Color(0xff777777),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          CustomText(
                            "Hello students, today’s class will start at 11:30 AM",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffF1F1F1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.mode_comment_outlined,
                                  color: Color(0xff777777),
                                  size: 14,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  AppLocalizations.of(context)!.comment,
                                  style: GoogleFonts.sourceSansPro(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child:
                                        Image.asset("assets/images/photo.png"),
                                    radius: 18,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomText(
                                    "Vedant Singh",
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              CustomText(
                                "24 Aug, 10:45 AM",
                                style: GoogleFonts.sourceSansPro(
                                  color: Color(0xff777777),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          CustomText(
                            "Hello students, today’s class will start at 11:30 AM",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffF1F1F1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.mode_comment_outlined,
                                  color: Color(0xff777777),
                                  size: 14,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  AppLocalizations.of(context)!.comment,
                                  style: GoogleFonts.sourceSansPro(
                                    color: Color(0xff777777),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
            childCount: 1,
          ),
        )
      ],
    ));
  }
}
