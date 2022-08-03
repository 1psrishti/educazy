import 'package:flutter/material.dart';


class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }
}



class TaglineText extends StatelessWidget {
  final String text;

  const TaglineText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff5B5B5B),
        fontSize: 14,
      ),
    );
  }
}
