import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/widgets/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ScreenWrapper extends StatefulWidget {
  final Widget child;
  const ScreenWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Stack(
          children: [
            DraggableFloatingActionButton(
              child: widget.child,
              initialOffset: Offset(300, 750),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
