import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/url.dart';
import '../models/question.dart';

class QuestionRepo {
  Future<List<Question>> getQuestion(String title) async {
    var url = Uri.parse(Url.getQuestion);
    var res = await http.post(url, body: {
      "title": title,
    });
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> insertQuestion(
      String title,
      String content,
      String answerA,
      String answerB,
      String answerC,
      String answerD,
      String answerIndex) async {
    var url = Uri.parse(Url.insertQuestion);
    await http.post(url, body: {
      "title": title,
      "content": content,
      "answer_a": answerA,
      "answer_b": answerB,
      "answer_c": answerC,
      "answer_d": answerD,
      "answer_index": answerIndex
    });
  }

  Future<void> deleteQuestion(String content) async {
    var url = Uri.parse(Url.deleteQuestion);
    await http.post(url, body: {
      "content": content,
    });
  }

  Future<void> updateQuestion(
      String contentOld,
      String content,
      String answerA,
      String answerB,
      String answerC,
      String answerD,
      String answerIndex) async {
    var url = Uri.parse(Url.updateQuestion);
    await http.post(url, body: {
      "contentOld": contentOld,
      "content": content,
      "answer_a": answerA,
      "answer_b": answerB,
      "answer_c": answerC,
      "answer_d": answerD,
      "answer_index": answerIndex
    });
  }
}
