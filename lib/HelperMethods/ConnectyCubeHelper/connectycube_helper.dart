import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/cupertino.dart';

class ConnectyCubeHelper {
  static attachConnectyCubeSdk() {
    String appId = "6041";
    String authKey = "QGgRv-fy2fVegFU";
    String authSecret = "Vje3OhG9KXAZUxh";

    init(appId, authKey, authSecret);
    CubeSettings.instance.isDebugEnabled =
        true; // to enable ConnectyCube SDK logs;
  }

  String createmeeting(
      String name, List<CubeMeetingAttendee> attendees, bool record) {
    String confRoomId = "";
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    CubeMeeting meeting = CubeMeeting()
      ..name = name
      ..attendees = attendees
      ..startDate = now
      ..endDate = now + 60 * 60
      ..withChat = true
      ..record = record;

    createMeeting(meeting).then((createdMeeting) {
      confRoomId = createdMeeting.meetingId ?? "";
    }).catchError((onError) {
      debugPrint(onError);
    });
    return confRoomId;
  }
}
