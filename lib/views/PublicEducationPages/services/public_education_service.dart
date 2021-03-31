import 'package:bizeozel/views/PublicEducationPages/model/public_education_model.dart';
import 'package:dio/dio.dart';

var dio = Dio();

Future getPublicEducation(String sehir) async {
  var response = await dio
      .get('https://bizeozel-1a95b-default-rtdb.firebaseio.com/$sehir.json');
  final responseData = response.data;
  final items = responseData.map((e) {
    final item = Kurs.fromJson(e.values.first);
    return item;
  }).toList();
  return items;
}
