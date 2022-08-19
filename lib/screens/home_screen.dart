import 'dart:math';

import 'package:connectycube_sdk/connectycube_sdk.dart';

import 'package:educazy/dataProviders/quiz_data_provider.dart';
import 'package:educazy/dataProviders/timer_data.dart';
import 'package:educazy/helper_methods.dart';
import 'package:educazy/screens/connectycube_screens/login_screen.dart';
import 'package:educazy/screens/incoming_call.dart';
import 'package:educazy/screens/progress_card_screen.dart';
import 'package:educazy/screens/quiz_screens/quiz_ques.dart';
import 'package:educazy/screens/resources_screen.dart';

import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'homescreen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Random? rand = Random();

class _HomeScreenState extends State<HomeScreen> {
  // static const String TAG = "LoginScreen.BodyState";

  // bool _isLoginContinues = false;
  // int? _selectedUserId;
  // Set<int> _selectedUsers = {};

  // late CallManager _callManager;
  // late ConferenceClient _callClient;
  // ConferenceSession? _currentCall;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initForegroundService();

    // CubeSettings.instance.onSessionRestore = () {
    //   return createSession(widget.currentuser);
    // };

    // _initConferenceConfig();
    // _initCalls();
  }

  // void _initCalls() {
  //   _selectedUsers.add(users[0].id!);
  //   // _selectedUsers.add(users[1].id!);
  //   // _selectedUsers.add(users[2].id!);
  //   _callClient = ConferenceClient.instance;
  //   _callManager = CallManager.instance;
  //   _callManager.onReceiveNewCall = (meetingId, participantIds) {
  //     _showIncomingCallScreen(meetingId, participantIds);
  //   };

  //   _callManager.onCloseCall = () {
  //     _currentCall = null;
  //   };
  // }

  // void _startCall(Set<int> opponents, {bool startScreenSharing = false}) async {
  //   if (opponents.isEmpty) return;

  //   var attendees = opponents.map((entry) {
  //     return CubeMeetingAttendee(userId: entry);
  //   }).toList();

  //   var startDate = DateTime.now().microsecondsSinceEpoch ~/ 1000;
  //   var endDate = startDate + 2 * 60 * 60; //create meeting for two hours

  //   CubeMeeting meeting = CubeMeeting(
  //     name: 'Conference Call',
  //     startDate: startDate,
  //     endDate: endDate,
  //     attendees: attendees,
  //   );
  //   createMeeting(meeting).then((createdMeeting) async {
  //     _currentCall = await _callClient.createCallSession(
  //         createdMeeting.hostId!, CallType.VIDEO_CALL, startScreenSharing);

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ConversationCallScreen(_currentCall!,
  //             createdMeeting.meetingId!, opponents.toList(), false),
  //       ),
  //     );
  //   });
  // }

  // void _showIncomingCallScreen(String meetingId, List<int> participantIds) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => IncomingCallScreen(meetingId, participantIds),
  //     ),
  //   );
  // }

  // void _initConferenceConfig() {
  //   ConferenceConfig.instance.url = SERVER_ENDPOINT;
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 60),
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/image.png'),
                      const SizedBox(height: 34),
                      const Text(
                        "Join the Class",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Explore, question, learn. Connect virtually with the "
                        "guided support of sign language detection and "
                        "subtitles.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Color(0xffAEAEAE),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const TextField(
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter code - Excyyz-99990",
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Color(0xff8D8D8D))),
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          // startBackgroundExecution().then((_) {
                          //   _startCall(_selectedUsers, startScreenSharing: true);
                          // });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConnectyCubeLoginScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            "Join Class",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xff62C733),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 44),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Tabs(
                                  onPressed: (() {}),
                                  imagePath: "assets/images/classes.png",
                                  text: "Join\nClasses"),
                              Tabs(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                MultiProvider(
                                                  providers: [
                                                    ChangeNotifierProvider(
                                                        create: (context) =>
                                                            QuizData()),
                                                    ChangeNotifierProvider(
                                                        create: (context) =>
                                                            TimerData()),
                                                  ],
                                                  child: const QuizQues(),
                                                ))));
                                  },
                                  imagePath: "assets/images/tests.png",
                                  text: "Tests"),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Tabs(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Progresscard.name);
                                  },
                                  imagePath: "assets/images/progress_cards.png",
                                  text: "Progress\nCard"),
                              Tabs(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Resources.name);
                                  },
                                  imagePath: "assets/images/resources.png",
                                  text: "Resources"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 62),
                    ],
                  ),
                ),
                const Text(
                  "Events",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Upcoming events conducted for you. Find new doors of "
                  "opportunities.",
                  style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                ),
                const SizedBox(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset('assets/images/img1.png'),
                      const SizedBox(width: 10),
                      Image.asset('assets/images/img2.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 46),
                const Text(
                  "Schedule",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Find your plans for the day.",
                  style: TextStyle(color: Color(0xff5B5B5B), fontSize: 14),
                ),
                const SizedBox(height: 24),
                Cards(
                  titleText: "Maternal Science Class",
                  date: "5 Aug 2022",
                  time: "9:30 AM to 10:30 AM",
                  text: "Session 3 - Topics covered : Decimal expressions, "
                      "terminating and non terminating rational numbers.",
                ),
                const SizedBox(height: 16),
                Cards(
                  titleText: "Maternal Science Class",
                  date: "5 Aug 2022",
                  time: "9:30 AM to 10:30 AM",
                  text: "Session 3 - Topics covered : Decimal expressions, "
                      "terminating and non terminating rational numbers.",
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
