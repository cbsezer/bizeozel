import 'package:cloud_firestore/cloud_firestore.dart';

Future getWorkOffers() async {
  var data = await FirebaseFirestore.instance.collection('WorkOffers').get();
  return data;
}
