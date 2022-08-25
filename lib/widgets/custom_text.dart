import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/enums/font_enum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;

  const CustomText(this.text, {Key? key, required this.style, this.textAlign})
      : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserAppData>(context);
    double size1 = 0.0;
    switch (provider.font) {
      case CustomFont.small:
        {
          size1 = (widget.style.fontSize ?? 14) - 2;
          break;
        }
      case CustomFont.medium:
        {
          size1 = (widget.style.fontSize ?? 14);
          break;
        }
      case CustomFont.large:
        {
          size1 = (widget.style.fontSize ?? 14) + 4;
          break;
        }
      default:
        {
          size1 = widget.style.fontSize ?? 14;
        }
    }

    return Text(
      widget.text,
      style: GoogleFonts.sourceSansPro(
          fontSize: size1,
          color: widget.style.color,
          fontWeight: widget.style.fontWeight),
    );
  }
}
