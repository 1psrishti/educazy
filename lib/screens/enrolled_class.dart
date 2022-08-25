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
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Goa', textScaleFactor: 1),
              background: Image.asset(
                'assets/images/social.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Text(
              'Social Studies',
              style: TextStyle(fontSize: 18, color: Color(0xFF2F2F2F)),
            )
          ]))
        ],
      ),
    );
  }
}
