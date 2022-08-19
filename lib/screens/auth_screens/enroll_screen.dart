import 'package:educazy/helper_methods.dart';
import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:educazy/screens/auth_screens/register_screen.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final enrollnamecontroller = TextEditingController();
final enrollschoolController = TextEditingController();
final enrolluserIdController = TextEditingController();

class EnrollScreen extends StatefulWidget {
  static const name = 'enrollscreen';
  const EnrollScreen({Key? key}) : super(key: key);

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF3B27), Color(0xFFFF8C4A)])),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                    height: 160,
                    width: 185,
                  ),
                  Text(
                    'educazy',
                    style: GoogleFonts.squadaOne(
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Enroll here",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Step into the world of accessible education.",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xffdfdfdf)),
                  ),
                  SizedBox(height: 0.1 * height),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: TextField(
                      controller: enrollnamecontroller,
                      keyboardType: TextInputType.name,
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
                          hintText: 'Please enter your full name',
                          hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF8D8D8D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: TextField(
                      controller: enrolluserIdController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.none,
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
                          hintText: 'Please enter your username',
                          hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF8D8D8D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    child: TextField(
                      controller: enrollschoolController,
                      keyboardType: TextInputType.name,
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
                          hintText: 'Select your school',
                          hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF8D8D8D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: (0.032 * width), vertical: 25),
                    child: MaterialButton(
                        minWidth: 0.85 * width,
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.name);
                        },
                        child: Container(
                          width: 0.85 * width,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFF2D66D6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            'Next',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Colors.white),
                          )),
                        )),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Already enrolled?',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0)),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.name);
                      },
                      child: Text(
                        'Click here to join the classroom',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
