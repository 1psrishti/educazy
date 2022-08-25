import 'package:educazy/screens/auth_screens/login_screen.dart';
import 'package:educazy/widgets/multi_select.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final registerpasswordController = TextEditingController();
final registerconfirmpasswordController = TextEditingController();
final registerclassController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  static const name = 'registerscreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<String> _selectedDisabilities = [];

  List<String> disabilities = [];
  String _text = "";

  void _showMultiSelectDropdown(List<String> items) async {
    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) => MultiSelect(
              items: items,
              title: 'Choose Disability',
            ));
    if (results != null) {
      setState(() {
        _text = "";
        _selectedDisabilities = results;
        if (results.isNotEmpty) {
          for (int i = 0; i < results.length; i++) {
            i != results.length - 1
                ? _text += results[i] + ", "
                : _text += results[i];
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    disabilities = ["Sight", "Speech", "Hearing", "Handicap", "Other"];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF3B27), Color(0xFFFF8C4A)])),
          child: SingleChildScrollView(
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
                  child: Text(
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
                  child: Text(
                    "Enter Your Details",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Step into the world of accesible education.",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 0.08 * height,
                ),
                InkWell(
                  onTap: () {
                    _showMultiSelectDropdown(disabilities);
                  },
                  child: Container(
                    width: 0.85 * width,
                    padding: EdgeInsets.symmetric(horizontal: 31, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      _selectedDisabilities.isEmpty
                          ? 'Select Your disability'
                          : _text,
                      style: GoogleFonts.poppins(
                        color: _selectedDisabilities.isEmpty
                            ? Color(0xFF8D8D8D)
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: TextField(
                    controller: registerclassController,
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
                        hintText: 'Enter your class',
                        hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF8D8D8D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: TextField(
                    controller: registerpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
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
                        hintText: 'Enter your password',
                        hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF8D8D8D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: TextField(
                    controller: registerconfirmpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
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
                        hintText: 'Confirm Password',
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
                      onPressed: () {
                        // HelperMethods.navigateTo(HomeScreen(), context);
                      },
                      child: Container(
                        width: 0.85 * width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF62C733),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'Enroll now',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.white),
                        )),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: (0.032 * width),
                      right: (0.032 * width),
                      bottom: 25),
                  child: MaterialButton(
                      minWidth: 0.85 * width,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 0.85 * width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'Back',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.white),
                        )),
                      )),
                ),
                Text(
                  'Already enrolled?',
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
                      Navigator.pushNamed(context, LoginScreen.name);
                    },
                    child: Text(
                      'Click here to join the classroom',
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
