import 'package:educazy/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 13, left: 23),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
            child: Row(
          children: [
            Image.asset(
              'assets/images/logo_head.png',
              color: Color(0xFFFF3423),
            ),
            SizedBox(
              width: 8,
            ),
            GradientText(
              "educazy",
              style: GoogleFonts.squadaOne(
                  fontSize: 22, fontWeight: FontWeight.w400),
              gradient: LinearGradient(colors: [
                Color(0xFFFF3423),
                Color(0xFFFF8C4A),
              ]),
            )
          ],
        )),
      ),
    );
  }
}
