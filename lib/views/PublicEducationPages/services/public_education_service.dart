import 'dart:convert';

import 'package:bizeozel/views/PublicEducationPages/model/public_education_model.dart';
import 'package:dio/dio.dart';

var dio = Dio();

List<Course> courses = [];

getPublicEducation(String sehir) async {
  var response = await dio.get('https://bizeozel-1a95b-default-rtdb.firebaseio.com/$sehir.json');
  final responseData = response.data;
  print('responsedata' + responseData.toString());
  print('ressssssss' + response.toString());
  print(responseData.length);
  //courses = Course.fromJson(json.decode(responseData)) as List;
}
