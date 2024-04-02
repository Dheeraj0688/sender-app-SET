import 'dart:async';
<<<<<<< HEAD

import 'dart:ui';

=======
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> a4876d9 ([first commit])
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:sender_app/domain/SessionControl.dart';
import 'package:sender_app/domain/debug_printer.dart';
<<<<<<< HEAD

import 'package:sender_app/domain/location_service.dart';

=======
import 'package:sender_app/domain/local_firestore.dart';
import 'package:sender_app/domain/location_service.dart';
import 'package:sender_app/domain/services/call_native_code.dart';
import 'package:sender_app/domain/experimental/video_recorder.dart';
import 'package:sender_app/domain/webrtc_receiver.dart';
import 'package:sender_app/domain/legacy/socket_client.dart';
>>>>>>> a4876d9 ([first commit])
import 'package:sender_app/domain/webrtc_sender.dart';

import 'package:sender_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FlutterBackgroundService> initializeService() async {
  print("[initializeService] initializing service");
  DebugFile.saveTextData('[intitializeService] Configuring service');
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(),
  );
  return service;
}

@pragma('vm:entry-point')
void onStart(
  ServiceInstance service,
) async {
<<<<<<< HEAD
=======
  WidgetsFlutterBinding.ensureInitialized();
>>>>>>> a4876d9 ([first commit])
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  await DebugFile.createFile();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
<<<<<<< HEAD
=======
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }
  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if ((await service.isForegroundService())) {
        service.setForegroundNotificationInfo(
          title: "service for realtime video stream",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
>>>>>>> a4876d9 ([first commit])

  late String userEmail = 'rpdiwte@gmail.com';
  late String receiverEmail = 'rushikesh9595092018@gmail.com';
  late int minutesToStart = 0;
<<<<<<< HEAD
  late int timeSlot = 1;
=======
  late int minutesToStop = 10;
>>>>>>> a4876d9 ([first commit])
  late List<String>? services = [
    'VIDEO_SAMPLE',
    'LIVE_LOCATION',
    'AUDIO_STREAM'
  ];

<<<<<<< HEAD
  Future<void> performDeactivation() async {
    await SessionControl.notifyReceiver(
      connected: false,
    );
    if (services!.contains('VIDEO_STREAM') ||
        services.contains('AUDIO_STREAM')) {
      await WebrtcSender.hangUp();

      print('[service.onStart] VIDEO_STREAM service successfully deactivated');

      DebugFile.saveTextData(
          '[service.onStart] VIDEO_STREAM service successfully deactivated');
    }
    SessionControl.deleteSession();

    await Future.delayed(Duration(seconds: 5));
    print('[service.onStart] stopping service.');
    DebugFile.saveTextData('[service.onStart] Stopping service.');
    service.stopSelf();
  }

=======
>>>>>>> a4876d9 ([first commit])
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    SharedPreferences info = await SharedPreferences.getInstance();
    userEmail = info.getString('userEmail')!;
    receiverEmail = info.getString('receiverEmail')!;
    minutesToStart = info.getInt("minutesToAutoConnect")!;
<<<<<<< HEAD
    timeSlot = info.getInt('timeSlot')!;
    services = info.getStringList('services')!;

    print(
        '[service.onStart] got userEmail: $userEmail, receiverEmail:$receiverEmail, minutesToStart:$minutesToStart, timeSlot:$timeSlot, services:$services');
    DebugFile.saveTextData(
        '[service.onStart] got userEmail: $userEmail, receiverEmail:$receiverEmail, minutesToStart:$minutesToStart, timeSlot:$timeSlot, services:$services');
=======
    minutesToStop = info.getInt('minutesToDissconnect')!;
    services = info.getStringList('services')!;

    print(
        '[service.onStart] got userEmail: $userEmail, receiverEmail:$receiverEmail, minutesToStart:$minutesToStart, minutesToStop:$minutesToStop, services:$services');
    DebugFile.saveTextData(
        '[service.onStart] got userEmail: $userEmail, receiverEmail:$receiverEmail, minutesToStart:$minutesToStart, minutesToStop:$minutesToStop, services:$services');
>>>>>>> a4876d9 ([first commit])

    Future.delayed(Duration(minutes: minutesToStart)).then((value) async {
      SessionControl.feedParameters(uEmail: userEmail, rEmail: receiverEmail);
      await SessionControl.notifyReceiver(
        connected: true,
      );
      await SessionControl.sendMessage(
        title: 'reply',
        message: 'READY',
      );

      if (services!.contains('VIDEO_STREAM') ||
          services.contains('AUDIO_STREAM')) {
        WebrtcSender.feedParameters(uEmail: userEmail, rEmail: receiverEmail);
        await WebrtcSender.listenForCommand();
        print('[service.onStart] VIDEO_STREAM service successfully activated');
        DebugFile.saveTextData(
            '[service.onStart] VIDEO_STREAM service successfully activated');
      }
      if (services.contains('LIVE_LOCATION')) {
        LocationService.feedParameters(
            rEmail: receiverEmail, uEmail: userEmail);

        LocationService.listenForRequest();

        print('[service.onStart] LIVE_LOCATION service successfully activated');
        DebugFile.saveTextData(
            '[service.onStart] LIVE_LOCATION service successfully activated');
      }
      if (services.contains('VIDEO_SAMPLE')) {
        // await callNativeMethod();
      }
<<<<<<< HEAD

      Future.delayed(Duration(minutes: timeSlot)).then((value) async {
        print('[onStart] performing stop');
        await performDeactivation();
      });
=======
    });

    Future.delayed(Duration(minutes: minutesToStop)).then((value) async {
      await SessionControl.notifyReceiver(
        connected: false,
      );
      if (services!.contains('VIDEO_STREAM') ||
          services.contains('AUDIO_STREAM')) {
        await WebrtcSender.hangUp();

        print(
            '[service.onStart] VIDEO_STREAM service successfully deactivated');

        DebugFile.saveTextData(
            '[service.onStart] VIDEO_STREAM service successfully deactivated');
      }
      SessionControl.deleteSession();

      await Future.delayed(Duration(seconds: 5));
      print('[service.onStart] stopping service.');
      DebugFile.saveTextData('[service.onStart] Stopping service.');
      service.stopSelf();
>>>>>>> a4876d9 ([first commit])
    });
  } catch (e) {
    print('[service.onStart] error ${e.toString()}');
    DebugFile.saveTextData('[service.onStart] error ${e.toString()}');
  }
<<<<<<< HEAD

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('stopService').listen((event) async {
      await performDeactivation();
      //service.stopSelf();
    });
  }
  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if ((await service.isForegroundService())) {
        service.setForegroundNotificationInfo(
          title: "service for realtime video stream",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
=======
>>>>>>> a4876d9 ([first commit])
}
