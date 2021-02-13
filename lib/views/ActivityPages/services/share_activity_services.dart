import 'package:bizeozel/views/ActivityPages/model/ActivityModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final TextEditingController _location = TextEditingController();
final TextEditingController _date = TextEditingController();
final TextEditingController _title = TextEditingController();
final TextEditingController _description = TextEditingController();

Future<dynamic> postImage(imageFile) async {
  var fileName = DateTime.now().millisecondsSinceEpoch.toString();
  var reference = FirebaseStorage.instance.ref().child('Activities').child('activity' + fileName + '.jpg');
  var uploadTask = reference.putFile(imageFile);
  var storageTaskSnapshot = await uploadTask.onComplete;
  print(storageTaskSnapshot.ref.getDownloadURL());
  return storageTaskSnapshot.ref.getDownloadURL();
}

Future postShare(imageFile) async {
  var user = FirebaseAuth.instance.currentUser;
  var shareName = DateTime.now().microsecondsSinceEpoch.toString();
  var db = Sharing(
    user.uid,
    shareName,
    DateTime.now(),
    _location.text,
    _date.text,
    imageFile.toString(),
    _description.text,
    _title.text,
    [],
    [],
    0,
  );
  var studentInfo = FirebaseFirestore.instance.collection('Forum').doc(shareName);
  await studentInfo.set(db.toMap());
  await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
    'listOfPost': FieldValue.arrayUnion([shareName]),
  });
  await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
    'listOfPost': FieldValue.arrayUnion([shareName]),
  });
}
