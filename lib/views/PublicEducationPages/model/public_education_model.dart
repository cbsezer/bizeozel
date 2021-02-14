class Kurs {
  String courseCentre;
  String courseCity;
  String courseDates;
  String courseName;

  Kurs({this.courseCentre, this.courseCity, this.courseDates, this.courseName});

  Kurs.fromJson(Map<String, dynamic> json) {
    courseCentre = json['Course Centre'];
    courseCity = json['Course City'];
    courseDates = json['Course Dates'];
    courseName = json['Course Name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Course Centre'] = courseCentre;
    data['Course City'] = courseCity;
    data['Course Dates'] = courseDates;
    data['Course Name'] = courseName;
    return data;
  }

  String get courseCentre1 => courseCentre;
}
