import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/enums/font_enum.dart';
import 'package:educazy/main.dart';
import 'package:educazy/screens/account_settings_screen.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:educazy/widgets/toggle_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  static const name = 'profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentscreen = ProfileScreen.name;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    var provider = Provider.of<UserAppData>(context);
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          color: !isDarkMode ? Color(0xFFF9F9F9) : Color(0xFF131313),
          duration: Duration(milliseconds: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  color: const Color(0xff0A5580),
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
                              CustomText(
                                "Shwet Mishra",
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              CustomText(
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
                      CustomText(
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AccountSettingsScreen.name);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: Theme.of(context).cardColor,
                    child: Option(
                      icon: Icons.settings_outlined,
                      text:
                          '${AppLocalizations.of(context)!.profile} ${AppLocalizations.of(context)!.settings}',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        AppLocalizations.of(context)!.support,
                        style: GoogleFonts.sourceSansPro(
                          color: Color(0xff555555),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Option(
                        icon: Icons.info_outline,
                        text: AppLocalizations.of(context)!.assistive_support,
                      ),
                      const SizedBox(height: 16),
                      Option(
                        icon: Icons.help_outline,
                        text: AppLocalizations.of(context)!.help,
                      ),
                      const SizedBox(height: 16),
                      Option(
                        icon: Icons.info_outline,
                        text:
                            AppLocalizations.of(context)!.terms_and_conditions,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Option(
                        icon: Icons.dark_mode_outlined,
                        text: AppLocalizations.of(context)!.dark_mode,
                      ),
                      const ToggleThemeButton()
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Option(
                        icon: Icons.dark_mode_outlined,
                        text: AppLocalizations.of(context)!.language,
                      ),
                      const ToggleLanguage()
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Option(
                        icon: Icons.text_format,
                        text: AppLocalizations.of(context)!.change_font,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              FontAwesome.minus,
                              // color: Color(0xff777777),
                              size: 12,
                            ),
                            onPressed: () {
                              if (provider.font == CustomFont.large) {
                                provider.setFont(CustomFont.medium);
                              } else if (provider.font == CustomFont.medium) {
                                provider.setFont(CustomFont.small);
                              }
                            },
                          ),
                          CustomText(
                            provider.font.name,
                            style: TextStyle(),
                          ),
                          IconButton(
                            icon: Icon(
                              FontAwesome.plus,
                              size: 12,
                            ),
                            onPressed: () {
                              if (provider.font == CustomFont.small) {
                                provider.setFont(CustomFont.medium);
                              } else if (provider.font == CustomFont.medium) {
                                provider.setFont(CustomFont.large);
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Option(
                    icon: Icons.logout_outlined,
                    text: AppLocalizations.of(context)!.log_out,
                  ),
                ),
              ],
            ),
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
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isDarkMode ? Color(0xff1B1B1B) : Color(0xffF1F1F1),
          ),
          child: Icon(
            icon,
            size: 15,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        CustomText(
          text,
          style: GoogleFonts.sourceSansPro(
            //   color: Color(0xff2F2F2F),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
