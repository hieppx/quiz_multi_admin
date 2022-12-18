import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/url.dart';
import '../models/course.dart';

class CourseRepo {
  Future<List<Course>> getCourse() async {
    var url = Uri.parse(Url.getCourse);
    var res = await http.post(
      url,
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> insertCourse(String title) async {
    var url = Uri.parse(Url.insertCourse);
    await http.post(url, body: {
      'title': title,
    });
  }

  Future<void> deleteCourse(String title) async {
    var url = Uri.parse(Url.deleteCourse);
    await http.post(url, body: {
      'title': title,
    });
  }

  Future<void> updateCourse(String title, String active, String value) async {
    var url = Uri.parse(Url.updateCourse);
    await http.post(url, body: {
      'titleOld': value,
      'title': title,
      'active': active,
    });
  }
}
