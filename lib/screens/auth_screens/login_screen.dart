import 'dart:math';

import 'package:educazy/DioHelper/dio_client.dart';
import 'package:educazy/screens/auth_screens/register_screen.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';

Random? rand = Random();
final logInUserIdController = TextEditingController();
final logInPasswordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  static const name = 'log in Screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DioClient? _dioClient = DioClient();

  @override
  void initState() {
    super.initState();

    currentscreen = LoginScreen.name;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      showAppBar: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFF3B27), Color(0xFFFF8C4A)])),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 180,
                    width: 195,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 180,
                      width: 195,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: CustomText(
                    'Educazy',
                    style: GoogleFonts.squadaOne(
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: CustomText(
                    "Welcome Back",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                  "Keep learning, keep growing.",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 0.08 * height,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: TextField(
                    controller: logInUserIdController,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.55),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2)),
                        hintText: 'Please Enter Unique User ID',
                        hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF8D8D8D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: TextField(
                    controller: logInPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textCapitalization: TextCapitalization.words,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.55),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2)),
                        hintText: 'Please Enter Password',
                        hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF8D8D8D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: (0.032 * width), vertical: 25),
                  child: MaterialButton(
                      minWidth: 0.85 * width,
                      onPressed: () async {
                        await _dioClient!.login(
                            username: logInUserIdController.text,
                            password: logInPasswordController.text,
                            context: context);
                      },
                      child: Container(
                        width: 0.85 * width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF62C733),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: CustomText(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.white),
                            )),
                      )),
                ),
                CustomText(
                  'Didn\’t enroll yet?',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0)),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.name);
                    },
                    child: CustomText(
                      'Click here to enroll now',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}