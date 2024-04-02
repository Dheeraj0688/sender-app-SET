import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:sender_app/domain/debug_printer.dart';
import 'package:sender_app/domain/services/fl_background_service.dart';
import 'package:sender_app/domain/experimental/legacy_fl_background_service.dart';
import 'package:sender_app/user/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

setAutoConnect(
    {required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String receiverEmail,
    required List<String> services}) {
  late int minutesToAutoConnect;
<<<<<<< HEAD
  //late int minutesToDissconnect;
=======
  late int minutesToDissconnect;
>>>>>>> a4876d9 ([first commit])
  late int timeSlot;

  int _calculateTimeDifference(TimeOfDay startTime, TimeOfDay endTime) {
    // Convert time to minutes
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    // Calculate the time difference
    int difference = endMinutes - startMinutes;
    print(
        '[setAutoConnect.calculateTimeDifference] calculating difference in autoConnect. start time is $startTime & endTime is $endTime');
    DebugFile.saveTextData(
        '[setAutoConnect.calculateTimeDifference] calculating difference in autoConnect. start time is $startTime & endTime is $endTime');
    return difference;
  }

  Future<void> saveToSharedPreferences() async {
<<<<<<< HEAD
    debugPrint(
        "[setAutoConnect] Saving to shared preferences: timeSlot: $timeSlot, $minutesToAutoConnect");
=======
>>>>>>> a4876d9 ([first commit])
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('timeSlot', timeSlot);
    prefs.setString('userEmail', CurrentUser.user['userEmail']);
    prefs.setString('receiverEmail', receiverEmail);

    prefs.setInt('minutesToAutoConnect',
        minutesToAutoConnect > 1 ? minutesToAutoConnect : 0);
<<<<<<< HEAD
    // prefs.setInt('minutesToDissconnect', minutesToDissconnect);
=======
    prefs.setInt('minutesToDissconnect', minutesToDissconnect);
>>>>>>> a4876d9 ([first commit])
    prefs.setStringList('services', services);
  }

  timeSlot = _calculateTimeDifference(startTime, endTime);
  //setting auto connect 5 minutes earlier
  minutesToAutoConnect =
      _calculateTimeDifference(TimeOfDay.now(), startTime); //-5
<<<<<<< HEAD
  // minutesToDissconnect = _calculateTimeDifference(TimeOfDay.now(), endTime);
=======
  minutesToDissconnect = _calculateTimeDifference(TimeOfDay.now(), endTime);
>>>>>>> a4876d9 ([first commit])
  saveToSharedPreferences().then((value) {
    print("[setAutoConnect] successfully stored values in sharedpreferences");
    DebugFile.saveTextData(
        "[setAutoConnect] successfully stored values in sharedpreferences");
  });

  final service = FlutterBackgroundService();
  initializeService();

  service.startService();
}
