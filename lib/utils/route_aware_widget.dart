import 'package:educazy/HelperMethods/alan_ai_helper.dart';
import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  const RouteAwareWidget(this.name, {Key? key, required this.child})
      : super(key: key);

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   AlanAiHelper.setVisualState(widget.name);
  //   print("init ${widget.name}");
  // }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    print("dispose ${widget.name}");

    super.dispose();
  }

  @override
  // Called when the current route has been pushed.
  void didPush() {
    currentscreen = widget.name;
    debugPrint('didPush ${widget.name}');
    // AlanAiHelper.setVisualState(widget.name);
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    currentscreen = widget.name;
    print('didPopNext ${widget.name}');
    // AlanAiHelper.setVisualState(widget.name);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
