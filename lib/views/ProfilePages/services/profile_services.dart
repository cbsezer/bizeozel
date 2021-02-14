import 'package:bizeozel/views/ActivityPages/model/ActivityModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUser {
  Future<dynamic> getUserActivities(shareId) async {
    var activity;
    try {
      var result = await FirebaseFirestore.instance.collection('Activities').doc('${shareId}').get();
      if (result != null) {
        activity = Sharing.fromSnapshot(result);
        return activity;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }
}
