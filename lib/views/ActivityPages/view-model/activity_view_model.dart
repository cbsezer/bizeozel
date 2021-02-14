import 'package:bizeozel/views/ActivityPages/model/ActivityModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Future<List<dynamic>> getAllPost() async {
    var posts = [];
    try {
      var result =
          await FirebaseFirestore.instance.collection('Activities').orderBy('dateOfShare', descending: true).get();
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

  // ignore: missing_return
  Future saveComments(docID, userID, content, Sharing sharing) async {
    await FirebaseFirestore.instance.collection('Activities').doc(docID).collection('Comments').doc().set({
      'commentPublisher': userID,
      'commentContent': content.text,
      'commentDate': DateTime.now(),
    });
    sharing.commentCount += 1;
    await sharing.reference.update({
      'commentCount': sharing.commentCount,
    });
  }

  Future<List<dynamic>> getAllComments(docID) async {
    var comments = [];
    try {
      var result = await FirebaseFirestore.instance.collection('Activities').doc(docID).collection('Comments').get();
      if (result != null) {
        result.docs.forEach((element) {
          comments.add(element);
        });
      }
      return comments;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
