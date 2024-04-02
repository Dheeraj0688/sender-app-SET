import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  int CompareTo(TimeOfDay endTime) {
    // Convert TimeOfDay to minutes
    int startMin = hour * 60 + minute;
    int endMin = endTime.hour * 60 + endTime.minute;
    var now = TimeOfDay.now();
<<<<<<< HEAD

=======
>>>>>>> a4876d9 ([first commit])
    if (startMin > endMin) {
      return 1;
    }
    if (startMin == endMin) {
      return 2;
    }

    int difference = (startMin - endMin).abs();

    if (difference <= 5) {
      return 3;
    }

<<<<<<< HEAD
    if (hour <= now.hour) {
      if (hour < now.hour) return 4;
      if (minute < now.minute + 1) return 4;
    }
=======
    if (hour < now.hour || minute < now.minute + 1) return 4;
>>>>>>> a4876d9 ([first commit])

    return 0;
  }
}
