import 'dart:math';

import 'package:educazy/screens/classes_screen.dart';
import 'package:educazy/screens/profile_screen.dart';
import 'package:educazy/screens/resources_screen.dart';
import 'package:educazy/screens/test_portal_screen.dart';
import 'package:educazy/utils/theme_provider.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

int notifNo = 2;

const btmGlobalKey = GlobalObjectKey<State<BottomNavigationBar>>('hhhh');

class HomeScreen extends StatefulWidget {
  static const String name = 'homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Random? rand = Random();

class _HomeScreenState extends State<HomeScreen> {
  bool? isDarkMode;
  List<Widget> items = const [
    ClassesScreen(),
    TestPortal(),
    Resources(),
    ProfileScreen(),
  ];
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ScreenWrapper(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: selectedItem,
          children: items,
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: btmGlobalKey,
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          unselectedIconTheme:
              IconThemeData(color: Theme.of(context).disabledColor, size: 20),
          unselectedItemColor: Theme.of(context).disabledColor,
          selectedFontSize: 17,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor, size: 20),
          selectedItemColor: Theme.of(context).primaryColor,
          iconSize: 15,
          onTap: onItemTapped,
          currentIndex: selectedItem,
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
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }
}
