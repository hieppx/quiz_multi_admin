import 'package:flutter/widgets.dart';
import 'package:quiz_multi_admin/service/question.repo.dart';

import '../../../models/question.dart';

class QuestionModel extends ChangeNotifier {
  QuestionRepo questionRepo = QuestionRepo();
  List<Question> _question = [];
  List<Question> get question => _question;
  final List<Question> _questionTmp = [];

  final TextEditingController _searchQuestion = TextEditingController();
  TextEditingController get searchQuestion => _searchQuestion;

  void onSearch(String value) {
    _question = _questionTmp
        .where((element) =>
            element.content!.toUpperCase().contains(value.toUpperCase()))
        .toList();
    notifyListeners();
  }

  void getQuestion(String title) async {
    _question = [];
    List<Question> tmp = [];
    tmp = await questionRepo.getQuestion(title);
    for (var i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _questionTmp.add(item);
    }
    _question = _questionTmp;
    notifyListeners();
  }

  TextEditingController _contentQuestion = TextEditingController();
  TextEditingController get contentQuestion => _contentQuestion;

  TextEditingController _answerA = TextEditingController();
  TextEditingController get answerA => _answerA;

  TextEditingController _answerB = TextEditingController();
  TextEditingController get answerB => _answerB;

  TextEditingController _answerC = TextEditingController();
  TextEditingController get answerC => _answerC;

  TextEditingController _answerD = TextEditingController();
  TextEditingController get answerD => _answerD;

  TextEditingController _answerIndex = TextEditingController();
  TextEditingController get answerIndex => _answerIndex;

  void insertQuestion(String title) async {
    int index;
    if (_answerIndex.text == 'A') {
      index = 0;
    } else if (_answerIndex.text == 'B') {
      index = 1;
    } else if (_answerIndex.text == 'C') {
      index = 2;
    } else {
      index = 3;
    }

    await questionRepo.insertQuestion(title, _contentQuestion.text,
        _answerA.text, _answerB.text, _answerC.text, _answerD.text, '$index');
    _question.add(Question(
        content: _contentQuestion.text,
        options: [_answerA.text, _answerB.text, _answerC.text, _answerD.text],
        answerIndex: index));
    resetInput();
    notifyListeners();
  }

  void deleteQuestion(String content) async {
    _question.removeWhere((element) => element.content == content);
    await questionRepo.deleteQuestion(content);
    notifyListeners();
  }

  void resetInput() {
    _contentQuestion.text = '';
    _answerA.text = '';
    _answerB.text = '';
    _answerC.text = '';
    _answerD.text = '';
    _answerIndex.text = '';
    notifyListeners();
  }

  void setValueController(String content, String answerA, String answerB,
      String answerC, String answerD, int answerIndex) {
    String answer;
    if (answerIndex == 0) {
      answer = 'A';
    } else if (answerIndex == 1) {
      answer = 'B';
    } else if (answerIndex == 2) {
      answer = 'C';
    } else {
      answer = 'D';
    }
    _contentQuestion = TextEditingController(text: content);
    _answerA = TextEditingController(text: answerA);
    _answerB = TextEditingController(text: answerB);
    _answerC = TextEditingController(text: answerC);
    _answerD = TextEditingController(text: answerD);
    _answerIndex = TextEditingController(text: answer);
    notifyListeners();
  }

  void updateQuestion(String contentOld) async {
    int index;
    if (_answerIndex.text == 'A') {
      index = 0;
    } else if (_answerIndex.text == 'B') {
      index = 1;
    } else if (_answerIndex.text == 'C') {
      index = 2;
    } else {
      index = 3;
    }
    _question.removeWhere((element) => element.content == contentOld);
    _question.add(Question(
        content: _contentQuestion.text,
        options: [_answerA.text, _answerB.text, _answerC.text, _answerD.text],
        answerIndex: index));

    await questionRepo.updateQuestion(contentOld, _contentQuestion.text,
        _answerA.text, _answerB.text, _answerC.text, _answerD.text, '$index');
    notifyListeners();
  }
}
