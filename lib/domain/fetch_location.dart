import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sender_app/domain/debug_printer.dart';
import 'package:sender_app/user/user_info.dart';

class FetchLocation {
  // late final DocumentSnapshot senderMessagesDocument;
  late StreamController<Map<String, dynamic>> _myStreamController;
  late Stream<Map<String, dynamic>> _locationStream;
<<<<<<< HEAD
  late StreamSubscription subscription;
=======

>>>>>>> a4876d9 ([first commit])
  late String senderEmail;
  late String userEmail;
  static FetchLocation? _instance;
  static FetchLocation getInstance({required String senderEmail}) {
    _instance ??= FetchLocation();
<<<<<<< HEAD
    _instance!.userEmail = CurrentUser.user['userEmail'];
=======
    _instance!.userEmail =
        CurrentUser.user['userEmail']; //CurrentUser.user['userEmail'];
>>>>>>> a4876d9 ([first commit])
    _instance!.senderEmail = senderEmail;

    return _instance!;
  }

<<<<<<< HEAD
  closeLocationStream() async {
    await subscription.cancel();
    await _myStreamController.close();
=======
  closeLocationStream() {
    _myStreamController.close();
>>>>>>> a4876d9 ([first commit])
  }

  openLocationStream() {
    _myStreamController = StreamController<Map<String, dynamic>>();
<<<<<<< HEAD

=======
>>>>>>> a4876d9 ([first commit])
    _locationStream = _myStreamController.stream;
  }

  Stream<Map<String, dynamic>> get locationStream => _locationStream;

  // getMessageChannel() async {
  //   try {
  //     senderMessagesDocument = await FirebaseFirestore.instance
  //         .collection('sessions')
  //         .doc(userEmail)
  //         .collection(senderEmail)
  //         .doc('messages')
  //         .get();
  //     print('[FetchLocation.getsessions] Got senderMessagesDocument');
  //     DebugFile.saveTextData(
  //         '[FetchLocation.getsessions] Got senderMessagesDocument');
  //   } catch (e) {
  //     print(
  //         '[FetchLocation.getsessions] Error getting senderMessagesDocument: ${e.toString()}');
  //     DebugFile.saveTextData(
  //         '[FetchLocation.getsessions] Error getting senderMessagesDocument: ${e.toString()}');
  //   }
  // }

  sendLocationRequest() async {
<<<<<<< HEAD
    if (!_myStreamController.isClosed) {
      _myStreamController.add({
        'STATUS': 'SENDING_REQUEST',
      });
    }

=======
    _myStreamController.add({
      'STATUS': 'SENDING_REQUEST',
    });
>>>>>>> a4876d9 ([first commit])
    try {
      await FirebaseFirestore.instance
          .collection('sessions')
          .doc(userEmail)
          .collection(senderEmail)
          .doc('messages')
          .set({'command': 'SEND_ONE_TIME_LOCATION'});
      print('[FetchLocation.sendLocationRequest] Request sent');
      DebugFile.saveTextData(
          '[FetchLocation.sendLocationRequest] Request sent');

<<<<<<< HEAD
      subscription = FirebaseFirestore.instance
=======
      await FirebaseFirestore.instance
>>>>>>> a4876d9 ([first commit])
          .collection('sessions')
          .doc(userEmail)
          .collection(senderEmail)
          .doc('liveLocation')
          .snapshots()
          .listen((snapshot) {
        print(
            '[fetchLocation.sendLocationRequest] Got response ${snapshot.data()}');
        DebugFile.saveTextData(
            '[fetchLocation.sendLocationRequest] Got response ${snapshot.data()}');
        if (snapshot.exists) {
<<<<<<< HEAD
          if (!_myStreamController.isClosed) {
            _myStreamController.add({
              'STATUS': 'SENDER_ONE_TIME_LOCATION',
              'LOCATION': snapshot.data()!['location']
            });
          }
=======
          _myStreamController.add({
            'STATUS': 'SENDER_ONE_TIME_LOCATION',
            'LOCATION': snapshot.data()!['location']
          });
>>>>>>> a4876d9 ([first commit])
        } else {
          print('[FetchLocation.sendLocationRequest] snapshot does not exist');
          DebugFile.saveTextData(
              '[FetchLocation.sendLocationRequest] snapshot does not exist');
<<<<<<< HEAD
          if (!_myStreamController.isClosed) {
            _myStreamController
                .add({'ERROR': "getting location(waiting for sender to send)"});
          }
=======
          _myStreamController.add({'ERROR': "snapshot does not exist"});
>>>>>>> a4876d9 ([first commit])
        }
      });
    } catch (e) {
      print(
          '[FetchLocation.sendLocationRequest] Error sending request: ${e.toString()}');
      DebugFile.saveTextData(
          '[FetchLocation.sendLocationRequest] Error sending request: ${e.toString()}');
<<<<<<< HEAD
      if (!_myStreamController.isClosed) {
        _myStreamController
            .add({'ERROR': "Error sending request: ${e.toString()}"});
      }
=======
      _myStreamController
          .add({'ERROR': "Error sending request: ${e.toString()}"});
>>>>>>> a4876d9 ([first commit])
    }
  }
}
