import 'package:educazy/constants.dart';
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  String imagePath;
  String text;
  final void Function()? onPressed;

  Tabs({required this.imagePath, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Color(0xffFF633A),
        // focusColor: Colors.orange,
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.37,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Image.asset(imagePath),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  // fontFamily: "PoppinsMedium",
                  color: Color(0xff525252),
                  fontSize: 13,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            // color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: const Color(0xffFFD7CC),
            ),
            // boxShadow: [
            // BoxShadow(
            //   // color: Colors.grey.withOpacity(0.5),
            //   blurRadius: 5,
            //   offset: const Offset(0, 2),
            // ),
            // ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  String titleText;
  String date;
  String time;
  String text;

  Cards({
    required this.titleText,
    required this.date,
    required this.time,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 18,
              color: blue,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF4F4F4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff373737),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF4F4F4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule_outlined),
                    const SizedBox(width: 5),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff373737),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              color: Color(0xff5B5B5B),
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}

class TestCards extends StatelessWidget {
  String titleText;
  String date;
  String time;
  String profName;
  int maxMarks;

  TestCards({
    required this.titleText,
    required this.date,
    required this.time,
    required this.profName,
    required this.maxMarks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 18,
              color: blue,
            ),
          ),
          const SizedBox(height: 26),
          Text(
            "Professor: " + profName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Max Marks: " + maxMarks.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  const Icon(Icons.schedule_outlined),
                  const SizedBox(width: 5),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff373737),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Icon(Icons.calendar_today_outlined),
                  const SizedBox(width: 5),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff373737),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
