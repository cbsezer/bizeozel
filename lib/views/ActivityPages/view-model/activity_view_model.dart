import 'package:bizeozel/views/ActivityPages/model/ActivityModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Future<List<dynamic>> getAllPost() async {
    var posts = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection('Activities')
          .orderBy('dateOfShare', descending: true)
          .get();
      if (result != null) {
        result.docs.forEach((element) {
          posts.add(Sharing.fromSnapshot(element));
        });
      }
      return posts;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
