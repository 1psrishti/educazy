// import 'package:connectycube_sdk/connectycube_calls.dart';
// import 'package:connectycube_sdk/connectycube_sdk.dart';
// import 'package:educazy/HelperMethods/ConnectyCubeHelper/call_manager.dart';
// import 'package:educazy/screens/video_call.dart';
// import 'package:educazy/widgets/screen_wrapper.dart';
// import 'package:flutter/material.dart';

// class IncomingCallScreen extends StatelessWidget {
//   static const String TAG = "IncomingCallScreen";
//   final String _meetingId;
//   final List<int> _participantIds;

//   IncomingCallScreen(this._meetingId, this._participantIds);

//   @override
//   Widget build(BuildContext context) {
//     CallManager.instance.onCloseCall = () {
//       log("onCloseCall", TAG);
//       Navigator.pop(context);
//     };

//     return WillPopScope(
//         onWillPop: () => _onBackPressed(context),
//         child: Scaffold(
//             body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(36),
//                 child: Text(_getCallTitle(), style: TextStyle(fontSize: 28)),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 36, bottom: 8),
//                 child: Text("Members:", style: TextStyle(fontSize: 20)),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 86),
//                 child: Text(_participantIds.join(", "),
//                     style: TextStyle(fontSize: 18)),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(right: 36),
//                     child: FloatingActionButton(
//                       heroTag: "RejectCall",
//                       child: Icon(
//                         Icons.call_end,
//                         color: Colors.white,
//                       ),
//                       backgroundColor: Colors.red,
//                       onPressed: () => _rejectCall(context),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 36),
//                     child: FloatingActionButton(
//                       heroTag: "AcceptCall",
//                       child: Icon(
//                         Icons.call,
//                         color: Colors.white,
//                       ),
//                       backgroundColor: Colors.green,
//                       onPressed: () => _acceptCall(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         )));
//   }

//   _getCallTitle() {
//     String callType = "Video";
//     return "Incoming $callType call";
//   }

//   void _acceptCall(BuildContext context) async {
//     ConferenceSession callSession = await ConferenceClient.instance
//         .createCallSession(CubeChatConnection.instance.currentUser!.id!);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ConversationCallScreen(
//             callSession, _meetingId, _participantIds, true),
//       ),
//     );
//   }

//   void _rejectCall(BuildContext context) {
//     CallManager.instance.reject(_meetingId, false);
//     Navigator.pop(context);
//   }

//   Future<bool> _onBackPressed(BuildContext context) {
//     return Future.value(false);
//   }
// }
