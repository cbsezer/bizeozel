import 'package:bizeozel/views/ActivityPages/model/ActivityModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<dynamic> activityLikes(Sharing sharing, id) async {
  if (!sharing.listOfLikes.contains(id)) {
    sharing.listOfLikes.add(id);
    sharing.likeCount += 1;
  } else {
    sharing.listOfLikes.remove(id);
    sharing.likeCount -= 1;
  }
  try {
    await sharing.reference.update({
      'listOfLikes': sharing.listOfLikes,
      'likecount': sharing.likeCount,
    });
    return true;
  } catch (e) {
    print(e);
    return e;
  }
}

Future<dynamic> activityParticipants(Sharing sharing, id) async {
  if (!sharing.participants.contains(id)) {
    sharing.participants.add(id);
    sharing.participantCount += 1;
  } else {
    sharing.participants.remove(id);
    sharing.participantCount -= 1;
  }
  try {
    await sharing.reference.update({
      'listOfParticipants': sharing.listOfParticipants,
      'participantCount': sharing.getparticipantCount,
    });
    return true;
  } catch (e) {
    print(e);
    return e;
  }
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
