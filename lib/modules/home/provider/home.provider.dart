import 'package:flutter/cupertino.dart';

import '../../../models/course.dart';
import '../../../service/course.repo.dart';

class HomeModel extends ChangeNotifier {
  CourseRepo courseRepo = CourseRepo();

  List<Course> _course = [];
  List<Course> get course => _course;

  final List<Course> _courseTmp = [];

  final TextEditingController _searchCourse = TextEditingController();
  TextEditingController get searchCourse => _searchCourse;

  final TextEditingController _titleCourse = TextEditingController();
  TextEditingController get titleCourse => _titleCourse;

  TextEditingController? _editingCourse;
  TextEditingController? get editingCourse => _editingCourse;

  void getCourse() async {
    _course = [];
    List<Course> tmp = [];
    tmp = await courseRepo.getCourse();
    for (var i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _courseTmp.add(item);
    }
    _course = _courseTmp;
    notifyListeners();
  }

  void onSearch(String value) {
    _course = _courseTmp
        .where((element) =>
            element.title!.toUpperCase().contains(value.toUpperCase()))
        .toList();
    notifyListeners();
  }

  void initTitleCourse(String title) {
    _editingCourse = TextEditingController(text: title);
    notifyListeners();
  }

  void insertCourse() async {
    _course.add(Course(title: _titleCourse.text));
    await courseRepo.insertCourse(_titleCourse.text);
    _titleCourse.clear();
    notifyListeners();
  }

  void deleteCourse(String title) async {
    _course.removeWhere((element) => element.title == title);
    await courseRepo.deleteCourse(title);
    notifyListeners();
  }

  void updateCourse(String title, String active) async {
    _course.removeWhere((element) => element.title == title);
    _course.add(Course(title: _editingCourse!.text, active: int.parse(active)));
    await courseRepo.updateCourse(_editingCourse!.text, active, title);
    notifyListeners();
  }
}
