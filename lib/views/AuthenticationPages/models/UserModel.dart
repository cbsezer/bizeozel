import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  DocumentReference reference;
  String _fullname;
  String _email;
  String _uid;
  DateTime _dateOfRegistration;
  List _activitiesAttended;
  List _activities;

  Users({@required id, @required email}) {
    _uid = id;
    _email = email;
  }

  Users.Info(
    this._fullname,
    this._email,
    this._uid,
    this._dateOfRegistration,
    this._activitiesAttended,
    this._activities,
  );

  Users.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _uid = parsedMap['id'],
        _fullname = parsedMap['fullname'],
        _email = parsedMap['email'],
        _dateOfRegistration = (parsedMap['dateofregistration'] as Timestamp).toDate(),
        _activitiesAttended = parsedMap['activitiesAttended'],
        _activities = parsedMap['activities'];

  Map<String, dynamic> toMap() {
    return {
      'id': _uid,
      'fullname': _fullname,
      'email': _email,
      'dateOfRegistration': _dateOfRegistration,
      'activitiesAttended': _activitiesAttended,
      'activities': _activities,
    };
  }

  Users.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
