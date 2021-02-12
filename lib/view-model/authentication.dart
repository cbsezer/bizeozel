import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Global_variables.dart';

class Authentication {
  final String kullaniciID;
  Authentication({this.kullaniciID});

  Userid _userFormFirebaseUser(User user) {
    return user != null ? Userid(id: user.uid) : null;
  }

  // Auth change user stream
  Stream<Userid> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((event) => _userFormFirebaseUser(event));
  }

  Future kullaniciKayit(String gemail, String gpassword) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: gemail, password: gpassword);
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future giris(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      userID = userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }
Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
}



class Userid {
  final String id;
  Userid({this.id});
}
