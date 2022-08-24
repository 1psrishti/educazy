import 'dart:math';

import 'package:badges/badges.dart';
import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/helper_methods.dart';
import 'package:educazy/screens/classes.dart';
import 'package:educazy/screens/incoming_call.dart';
import 'package:educazy/screens/profile_screen.dart';
import 'package:educazy/screens/progress_card_screen.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/screens/test_portal_screen.dart';
import 'package:educazy/utils/custom_colors.dart';
import 'package:educazy/utils/theme_provider.dart';

import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:educazy/widgets/toggle_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dataProviders/user_app_data.dart';
import '../widgets/widgets.dart';

int notifNo = 2;

class HomeScreen extends StatefulWidget {
  static const String name = 'homescreen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Random? rand = Random();

class _HomeScreenState extends State<HomeScreen> {
  bool? isDarkMode;
  int tab_index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> items = [
    Classes(),
    TestPortal(),
    Resources(),
    ProfileScreen(),
  ];
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    var provider = Provider.of<UserAppData>(context);
    return ScreenWrapper(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: IndexedStack(
            index: provider.tabIndex,
            children: items,
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            unselectedIconTheme:
                IconThemeData(color: Theme.of(context).disabledColor, size: 20),
            unselectedItemColor: Theme.of(context).disabledColor,
            selectedFontSize: 17,
            selectedIconTheme:
                IconThemeData(color: Theme.of(context).primaryColor, size: 20),
            selectedItemColor: Theme.of(context).primaryColor,
            iconSize: 15,
            onTap: onItemTapped,
            currentIndex: provider.tabIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Feather.airplay),
                label: 'Classes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.book_open),
                label: 'Tests',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.book),
                label: 'Resources',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.user),
                label: 'Profile',
              ),
            ],
          )),
    );
  }

  void onItemTapped(int index) {
    Provider.of<UserAppData>(context, listen: false).setTabIndex(index);
  }
}
