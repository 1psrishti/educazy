import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EnrolledScreen extends StatefulWidget {
  const EnrolledScreen({Key? key}) : super(key: key);

  @override
  State<EnrolledScreen> createState() => _EnrolledScreenState();
}

class _EnrolledScreenState extends State<EnrolledScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            leading: GestureDetector(
              onTap: () {},
              child: Container(
                width: 24,
                height: 24,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            expandedHeight: 180,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: false,
              //  title: Text('Social Studies', textScaleFactor: 1),

              background: Image.asset(
                'assets/images/social.png',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    'Social Studies',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF2F2F2F),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  CustomText(
                      'Integrated study of multiple fields of social science and the humanities, including history, geography, and political science.',
                      style: TextStyle(fontSize: 14)),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    'by Mr. Vedant Singh',
                    style: TextStyle(fontSize: 14, color: Color(0xFF7777777)),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 128,
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [Text('')]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
