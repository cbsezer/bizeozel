import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String readTimestamp(Timestamp timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm');
  //var format2 = DateFormat('dd.MM.yyyy HH:mm');
  var date = (timestamp.toDate());
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays < 1) {
      time = format.format(date);
    } else if (diff.inDays == 1) {
      time = 'Dün ' + format.format(date);
    } else if (diff.inDays < 7) time = diff.inDays.toString() + ' GÖ';
  } else {
    time = diff.inDays.toString() + ' GÖ';
  }
  return time;
}
