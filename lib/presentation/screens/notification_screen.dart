<<<<<<< HEAD
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:sender_app/configs/device_info.dart';
import 'package:sender_app/domain/debug_printer.dart';
import 'package:sender_app/domain/local_firestore.dart';
import 'package:sender_app/domain/set_auto_connect.dart';

import 'package:sender_app/presentation/screens/request_screen.dart';
import 'package:sender_app/user/user_info.dart';
import 'package:sender_app/utils/sort.dart';
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sender_app/domain/debug_printer.dart';
import 'package:sender_app/domain/local_firestore.dart';
import 'package:sender_app/domain/set_auto_connect.dart';
import 'package:sender_app/presentation/screens/request_screen.dart';
import 'package:sender_app/user/user_info.dart';
>>>>>>> a4876d9 ([first commit])

class NotificationPage extends StatefulWidget {
  NotificationPage();
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<List<NotificationItem>> getData() async {
    try {
      late List<NotificationItem> notifications = [];
      final String userEmail = CurrentUser.user['userEmail'];

      Map<String, dynamic>? map =
          await FirestoreOps.accessNotification(userEmail);
      if (map == null) {
        return notifications;
      }
      List<MyModel> modelList = map!.entries.map((entry) {
        return MyModel.fromJson(entry.key, entry.value);
      }).toList();

<<<<<<< HEAD
      modelList = sort(modelList);
=======
>>>>>>> a4876d9 ([first commit])
      modelList.forEach((element) {
        notifications.add(NotificationItem(
            senderEmail: element.senderEmail,
            message: element.message,
            startTime: element.startTime,
            endTime: element.endTime,
            id: element.key,
            type: element.type,
            services: element.services));
      });
      DebugFile.saveTextData(
          '[NotificationPage.getData()] Got notification data');
      return notifications;
    } catch (e) {
      DebugFile.saveTextData(
          '[NotificationPage.getData()] Error while getting notification data: ${e.toString()}');
      return Future.error(e);
    }
  }

  @override
  void initState() {
<<<<<<< HEAD
    // TODO: implement initState
=======
>>>>>>> a4876d9 ([first commit])
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        appBar: AppBar(
          title: Text('Notifications'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // Refresh the screen by rebuilding it
                setState(() {});
              },
            ),
          ],
        ),
        body: FutureBuilder<List<NotificationItem>>(
          future: getData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<NotificationItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading, show a loading indicator or any other widget
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // If an error occurs during data loading, show an error message
              return Center(
                child: Text("Error loading data: ${snapshot.error}"),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text("No notifications"),
              );
            } else {
              // Data has been loaded successfully, display it
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (snapshot.data![index].type == "REQUEST") {
                    return NotificationCard(
                      id: snapshot.data![index].id,
                      message: snapshot.data![index].message,
                      startTime: snapshot.data![index].startTime,
                      endTime: snapshot.data![index].endTime,
                      senderEmail: snapshot.data![index].senderEmail,
                      services: snapshot.data![index].services,
                      context: context,
                    );
                  } else {
                    return SimpleNotification(
                      message: snapshot.data![index].message,
                      notId: snapshot.data![index].id,
                      userEmail: CurrentUser.user['userEmail'],
                      callback: () => this.setState(() {}),
                    );
                  }
                },
              ); // Replace "No data" with your desired default text
            }
          },
        ));
=======
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NotificationItem>>(
        future: getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error loading data: ${snapshot.error}"),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Text("No notifications"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (snapshot.data![index].type == "REQUEST") {
                  return NotificationCard(
                    id: snapshot.data![index].id,
                    message: snapshot.data![index].message,
                    startTime: snapshot.data![index].startTime,
                    endTime: snapshot.data![index].endTime,
                    senderEmail: snapshot.data![index].senderEmail,
                    services: snapshot.data![index].services,
                    context: context,
                    callback: () => setState(() {}),
                  );
                } else {
                  return SimpleNotification(
                    message: snapshot.data![index].message,
                    notId: snapshot.data![index].id,
                    userEmail: CurrentUser.user['userEmail'],
                    callback: () => setState(() {}),
                  );
                }
              },
            );
          }
        },
      ),
    );
>>>>>>> a4876d9 ([first commit])
  }
}

class NotificationCard extends StatelessWidget {
  final String id;
  final String senderEmail;
  final String message;
  final String startTime;
  final String endTime;
<<<<<<< HEAD
  late final String startTimeLocal;
  late final String endTimeLocal;
  final BuildContext context;
  final List<String> services;
  late final TimeOfDay newEndTime;
  late final TimeOfDay newStartTime;

  NotificationCard(
      {required this.senderEmail,
      required this.message,
      required this.startTime,
      required this.id,
      required this.endTime,
      required this.context,
      required this.services}) {
    newStartTime = stringToTimeOfDay(startTime);
    newEndTime = stringToTimeOfDay(endTime);

    startTimeLocal = newStartTime.format(context).toString();
    endTimeLocal = newEndTime.format(context).toString();
    debugPrint("new start end time $newStartTime $newEndTime ");
  }
  bool checkStartEndTime() {
    TimeOfDay now = TimeOfDay.now();
    if (newStartTime.hour < now.hour) return false;
    if (newStartTime.minute < now.minute) return false;

    return true;
  }

  TimeOfDay stringToTimeOfDay(String inputTime) {
    int hour = int.parse(inputTime.split(":")[0]);
    int minute = int.parse(inputTime.split(":")[1]);

    return TimeOfDay(hour: hour, minute: minute);
=======
  final BuildContext context;
  final List<String> services;
  final Function callback;

  NotificationCard({
    required this.senderEmail,
    required this.message,
    required this.startTime,
    required this.id,
    required this.endTime,
    required this.context,
    required this.services,
    required this.callback,
  });

  bool checkStartEndTime() {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay startTimeOfDay =
        TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(startTime));
    if (startTimeOfDay.hour < now.hour ||
        (startTimeOfDay.hour == now.hour && startTimeOfDay.minute < now.minute))
      return false;
    else
      return true;
>>>>>>> a4876d9 ([first commit])
  }

  approveRequest() async {
    await FirestoreOps.respondNotification({
      "userEmail": CurrentUser.user['userEmail'],
      "receiverEmail": senderEmail,
      "userResponse": "APPROVE",
      "requestNotificationId": id,
      "startTime": startTime,
      "endTime": endTime,
      "services": services
    });

<<<<<<< HEAD
    print("newStartTime: $newStartTime");
    print("newEndTime: $newEndTime");
    setAutoConnect(
        endTime: newEndTime,
        startTime: newStartTime,
        receiverEmail: this.senderEmail,
        services: services);
    DebugFile.saveTextData(
        '[NotificationCard] Allowed for ${this.senderEmail} with \nstartTime: $startTime, \nendTime:$endTime, \nservices:$services');
=======
    setAutoConnect(
      endTime: TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(endTime)),
      startTime: TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(startTime)),
      receiverEmail: senderEmail,
      services: services,
    );
    DebugFile.saveTextData(
      '[NotificationCard] Allowed for $senderEmail with \nstartTime: $startTime, \nendTime:$endTime, \nservices:$services',
    );
>>>>>>> a4876d9 ([first commit])
  }

  rejectRequest() async {
    await FirestoreOps.respondNotification({
      "userEmail": CurrentUser.user['userEmail'],
      "receiverEmail": senderEmail,
      "userResponse": "DENY",
      "requestNotificationId": id,
      "startTime": startTime,
      'services': services,
      "endTime": endTime,
    });
<<<<<<< HEAD
    DebugFile.saveTextData('[NotificationCard] denied for user ${senderEmail}');
=======
    DebugFile.saveTextData(
      '[NotificationCard] denied for user $senderEmail',
    );
  }

  deleteNotification() {
    FirestoreOps.deleteNotification(id, CurrentUser.user['userEmail']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification deleted'),
      ),
    );
    // Call the callback function to update the UI
    callback();
>>>>>>> a4876d9 ([first commit])
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${this.senderEmail}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('message: $message'),
            Text('location start time: $startTimeLocal'),
            Text('location end time: $endTimeLocal'),
            Text('services: $services'),
            SizedBox(height: 8.0),
            // checkStartEndTime()

            true
                ? Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            approveRequest();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestPage()));
                          },
                          child: const Text('Approve'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            rejectRequest();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestPage()));
                          },
                          child: const Text('Reject'),
                        ),
                      ),
                    ],
                  )
                : Text(
                    "Timeslot expired",
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
      ),
    );
=======
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
        elevation: 8,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Image.asset('images/profile.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '$senderEmail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth < 600 ? 16 : 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300]!,
              height: 2.0,
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8, top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Services:',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        // Images with gap
                        for (var service in services)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.asset(
                              getImagePath(service),
                              width: 24,
                              height: 24,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Start Time: ',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          startTime,
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                          'End Time: ',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          endTime,
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300]!,
              height: 1.0,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                      onPressed: () async {
                        approveRequest();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Approve',
                        style: TextStyle(color: Colors.green),
                      ),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(color: Colors.white),
                          elevation: 0)),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          rejectRequest();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Reject',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(color: Colors.white),
                            elevation: 0)),
                  ),
                  SizedBox(
                    width: 08,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type your reason here...',
                              ),
                              // Handle the entered text (you can save it to a variable)
                              onChanged: (value) {
                                // Handle the entered text (you can save it to a variable)
                                // For example: saveReason(value);
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors
                                        .black, // Set your desired border color
                                    width: 1.0, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Set the border radius
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    rejectRequest();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RequestPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Reject with reason',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
>>>>>>> a4876d9 ([first commit])
  }
}

class NotificationItem {
  final String id;
  final String senderEmail;
  final String message;
  final String startTime;
  final String endTime;
  final String? type;
  final List<String> services;

<<<<<<< HEAD
  NotificationItem(
      {required this.senderEmail,
      required this.message,
      required this.startTime,
      required this.endTime,
      required this.id,
      required this.type,
      required this.services});
}

//for each notification received from server( { id:{ details... }, id:...} )
=======
  NotificationItem({
    required this.senderEmail,
    required this.message,
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.type,
    required this.services,
  });
}

>>>>>>> a4876d9 ([first commit])
class MyModel {
  final String key;
  final String message;
  final String startTime;
  final String endTime;
  final String senderEmail;
  final String type;
  final List<String> services;

<<<<<<< HEAD
  MyModel(
      {required this.key,
      required this.message,
      required this.startTime,
      required this.endTime,
      required this.senderEmail,
      required this.type,
      required this.services});

  factory MyModel.fromJson(String key, Map<String, dynamic> map) {
    DebugFile.saveTextData(
        '[notification_screen.MyModel] Got data in MyModel key: $key value:$map ');
=======
  MyModel({
    required this.key,
    required this.message,
    required this.startTime,
    required this.endTime,
    required this.senderEmail,
    required this.type,
    required this.services,
  });

  factory MyModel.fromJson(String key, Map<String, dynamic> map) {
>>>>>>> a4876d9 ([first commit])
    List<String> serv = [];
    List<dynamic> list = map['services'] ?? [];
    list.forEach(
      (element) {
        serv.add(element);
      },
    );
    return MyModel(
<<<<<<< HEAD
        key: key,
        message: map['message'] ?? '',
        startTime: map['startTime'] ?? '',
        senderEmail: map['senderEmail'] ?? '',
        type: map['type'] ?? '',
        endTime: map['endTime'] ?? '',
        services: serv);
  }

  @override
  String toString() {
    return 'MyModel(key: $key, message: $message, ltime: $startTime $endTime, senderEmail: $senderEmail, req: $type, services: $services)';
=======
      key: key,
      message: map['message'] ?? '',
      startTime: map['startTime'] ?? '',
      senderEmail: map['senderEmail'] ?? '',
      type: map['type'] ?? '',
      endTime: map['endTime'] ?? '',
      services: serv,
    );
>>>>>>> a4876d9 ([first commit])
  }
}

class SimpleNotification extends StatelessWidget {
  final String message;
  final String notId;
  final String userEmail;
  final Function callback;

<<<<<<< HEAD
  const SimpleNotification(
      {required this.message,
      required this.notId,
      required this.userEmail,
      required this.callback});
=======
  const SimpleNotification({
    required this.message,
    required this.notId,
    required this.userEmail,
    required this.callback,
  });
>>>>>>> a4876d9 ([first commit])

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
<<<<<<< HEAD
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "general",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      FirestoreOps.deleteNotification(notId, userEmail);
                      callback();
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
            SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
=======
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Response',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        FirestoreOps.deleteNotification(notId, userEmail);
                        callback();
                      },
                      icon: Icon(Icons.delete))
                ]),
          ),
          Divider(
            color: Colors.grey[300]!,
            height: 1.0,
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Message:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300]!,
            height: 1.0,
          ),
        ],
>>>>>>> a4876d9 ([first commit])
      ),
    );
  }
}
<<<<<<< HEAD
=======

// Function to get image path based on service name
String getImagePath(String service) {
  switch (service) {
    case 'VIDEO_STREAM':
      return 'images/video-camera.png';
    case 'AUDIO_STREAM':
      return 'images/call.png';
    case 'LIVE_LOCATION':
      return 'images/person.png';
    default:
      return ''; // Default image path
  }
}
>>>>>>> a4876d9 ([first commit])
