import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountSettingsScreen extends StatefulWidget {
  static const name = 'accountSettingsScreen';
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    var textColor = isDarkMode ? Color(0xFFD0D0D0) : Color(0xff2F2F2F);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        leading: BackButton(color: textColor),
        title: CustomText(
          "Profile Settings",
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.edit_rounded,
                color: textColor,
              ),
              SizedBox(width: 4),
              CustomText(
                "EDIT",
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      // backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(24),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoText(
                      headerText: "Name",
                      infoText: "Shwet Mishra",
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    InfoText(
                      headerText: "Email Address",
                      infoText: "shwet.mishra@email.com",
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    InfoText(
                      headerText: "Phone Number",
                      infoText: "+91 9988765543",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(24),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: CustomText(
                  "Change Password",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(24),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoText(
                      headerText: "College Name",
                      infoText: "Indian Institute of Technology, Madras",
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    InfoText(
                      headerText: "Course",
                      infoText: "B.Tech",
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    InfoText(
                      headerText: "Semester",
                      infoText: "3rd",
                    ),
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

class InfoText extends StatelessWidget {
  late String headerText;
  late String infoText;

  InfoText({
    Key? key,
    required this.headerText,
    required this.infoText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    var textColor = isDarkMode ? Color(0xFFD0D0D0) : Color(0xff2F2F2F);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          headerText,
          style: GoogleFonts.inter(
            color: Color(0xff555555),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        CustomText(
          infoText,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
