import 'package:educazy/enums/font_enum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatefulWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final CustomFont? font;

  const CustomText({Key? key, required this.text, required this.color, required this.size, required this.fontWeight,this.font=CustomFont.medium}) : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {

  @override
  Widget build(BuildContext context) {
    double size1=0.0;
    switch(widget.font){
      case CustomFont.small:{
        size1=widget.size-2;
        break;

      }
      case CustomFont.medium:{
        size1=widget.size;
        break;
      }
      case CustomFont.large:{
        size1=widget.size+4;
        break;
      }
      default:{
        size1=widget.size;
      }

    }


    return Text(widget.text,style: GoogleFonts.sourceSansPro(fontSize: size1,color: widget.color,fontWeight: widget.fontWeight),);
  }
}
