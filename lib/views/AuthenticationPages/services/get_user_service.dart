import 'package:bizeozel/core/components/helpers/globalUserData.dart';
import 'package:bizeozel/views/AuthenticationPages/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<dynamic> getCurrentUser() async {
  var auth = FirebaseAuth.instance;
  var user = auth.currentUser;
  var _user;
  try {
    var result = await FirebaseFirestore.instance.collection('Users').doc('${user.uid}').get();
    if (result != null) {
      _user = Users.fromSnapshot(result);
    }

    userImgUrl = _user.imgUrl;
    fullname = _user.fullname;

    return _user;
  } catch (e) {
    print(e);
    return null;
  }
}
