import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  DocumentReference reference;
  String _fullname;
  String _email;
  String _uid;
  String _imgUrl;
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
    this._imgUrl,
    this._dateOfRegistration,
    this._activitiesAttended,
    this._activities,
  );

  Users.fromMap(Map<String, dynamic> mapping, {this.reference})
      : _uid = mapping['id'],
        _fullname = mapping['fullname'],
        _email = mapping['email'],
        _imgUrl = mapping['imgUrl'],
        _dateOfRegistration = (mapping['dateOfRegistration'] as Timestamp).toDate(),
        _activitiesAttended = mapping['activitiesAttended'],
        _activities = mapping['activities'];

  Map<String, dynamic> toMap() {
    return {
      'id': _uid,
      'fullname': _fullname,
      'email': _email,
      'imgUrl': _imgUrl,
      'dateOfRegistration': _dateOfRegistration,
      'activitiesAttended': _activitiesAttended,
      'activities': _activities,
    };
  }

  Users.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);

  String get fullname => _fullname;
  String get imgUrl => _imgUrl;
  String get email => _email;
  List get activitiesAttended => _activitiesAttended;
  List get activities => _activities;
  String get id => _uid;
}
