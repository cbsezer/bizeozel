import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'Global_variables.dart';



userIDgetter() {
  final user = FirebaseAuth.instance.currentUser;
  userID = user.uid;
  return userID;
}

Future pullUserData() async {
  if (!check) {
    final user = FirebaseAuth.instance.currentUser;
    userID = user.uid;

    // Kullanıcı temel bilgileri çekildi:
    await userAccountInfo();
    await kullaniciTokeniAl();
    

    check = true;
    return true;
  } else {
    return true;
  }
}

Future userAccountInfo() async {
  /*
  Bu fonksiyon kullanıcıya ait temel bilgileri çeker.
  */
  var user =
      await FirebaseFirestore.instance.collection('Users').doc(userID).get();
  fullName = user['name'];
  email = user['email'];
  userID = user['userID'];
  
}

Future kullaniciTokeniAl() async {
  await FirebaseMessaging().getToken().then((onValue) async {
    await FirebaseFirestore.instance
        .collection('TokenData')
        .doc(userID)
        .set({
      'user_id': userID,
      'user_token': onValue,
    });
    userToken = onValue;
  });
}