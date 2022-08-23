import 'package:educazy/screens/account_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  static const name = 'profilescreen';
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                color: Color(0xff0A5580),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/photo.png'),
                          radius: 25,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shwet Mishra",
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Class 8 Student",
                              style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "SRM Public School, Nandhivaram, Tamil Nadu",
                      style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Option(
                  icon: Icons.settings_outlined,
                  text: "Profile Settings",
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Support",
                      style: GoogleFonts.sourceSansPro(
                        color: Color(0xff555555),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Option(
                      icon: Icons.info_outline,
                      text: "Assistive Support",
                    ),
                    const SizedBox(height: 16),
                    Option(
                      icon: Icons.help_outline,
                      text: "Help",
                    ),
                    const SizedBox(height: 16),
                    Option(
                      icon: Icons.info_outline,
                      text: "Terms & Privacy",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Option(
                      icon: Icons.dark_mode_outlined,
                      text: "Dark Mode",
                    ),
                    CupertinoSwitch(
                      value: darkMode,
                      onChanged: (val) {
                        setState(() {
                          darkMode = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Option(
                  icon: Icons.logout_outlined,
                  text: "Log Out",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Option extends StatelessWidget {
  late IconData icon;
  late String text;

  Option({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AccountSettingsScreen.name);
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xffF1F1F1),
            ),
            child: Icon(
              icon,
              size: 15,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: GoogleFonts.sourceSansPro(
              color: Color(0xff2F2F2F),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
