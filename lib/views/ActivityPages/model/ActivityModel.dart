import 'package:cloud_firestore/cloud_firestore.dart';

class Sharing {
  DocumentReference reference;
  String _publisher;
  String _shareId;
  DateTime _dateOfShare;
  String _location;
  List _participants;
  int _participantCount;
  String _activityDate;
  String _imgUrl;
  String _description;
  String _title;
  int _likeCount;
  int _commentCount;

  Sharing(
      [this._publisher,
      this._shareId,
      this._dateOfShare,
      this._location,
      this._participants,
      this._participantCount,
      this._activityDate,
      this._imgUrl,
      this._description,
      this._title,
      this._likeCount,
      this._commentCount]);

  Sharing.fromMap(Map<String, dynamic> mapping, {this.reference})
      : _shareId = mapping['shareId'],
        _publisher = mapping['publisher'],
        _dateOfShare = (mapping['dateOfShare'] as Timestamp).toDate(),
        _location = mapping['location'],
        _participants = mapping['participants'],
        _participantCount = mapping['participantCount'],
        _activityDate = mapping['activityDate'],
        _imgUrl = mapping['imgUrl'],
        _description = mapping['description'],
        _title = mapping['title'],
        _likeCount = mapping['likecount'],
        _commentCount = mapping['commentCount'];

  Map<String, dynamic> toMap() {
    return {
      'shareId': _shareId,
      'publisher': _publisher,
      'dateOfShare': _dateOfShare,
      'location': _location,
      'participants': _participants,
      'participantCount': _participantCount,
      'activityDate': _activityDate,
      'imgUrl': _imgUrl,
      'description': _description,
      'title': _title,
      'likecount': _likeCount,
      'commentCount': _commentCount,
    };
  }

  Sharing.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);

  String get title => _title;
  String get description => _description;
  String get imgUrl => _imgUrl;
  String get publisher => _publisher;
  String get activityDate => _activityDate;
  String get location => _location;
  DateTime get dateOfShare => _dateOfShare;
  int get likeCount => _likeCount;
  List get participants => _participants;
  int get participantCount => _participantCount;
  int get commentCount => _commentCount;
  String get shareId => _shareId;
}
