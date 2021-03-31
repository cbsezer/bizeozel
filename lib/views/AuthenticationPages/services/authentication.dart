import 'package:bizeozel/views/AuthenticationPages/models/UserModel.dart'
    as usr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  usr.Users userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return usr.Users(
        id: user.uid,
        email: user.email,
      );
    }
  }

  Future<usr.Users> currentUser() async {
    try {
      var _user = await FirebaseAuth.instance.currentUser;
      return userFromFirebase(_user);
    } catch (e) {
      print(e);
      return e;
    }
  }

  Stream<usr.Users> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((event) => userFromFirebase(event));
  }

  Future signup(String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    } catch (e) {
      print('Sign Up Function Error $e');
    }
  }

  Future login(String email, String password, BuildContext context) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
      // userID = userCredential.user.uid;

    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    } catch (e) {
      print('Login Function Error: $e');
    }
  }

  Future signOut() async {
    var _user = await FirebaseAuth.instance;
    await _user.signOut();
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
