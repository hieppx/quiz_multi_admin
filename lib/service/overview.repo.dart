import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/url.dart';

class OverviewRepo {
  final List<String> _listOverview = [];
  List<String> get listOverview => _listOverview;

  Future<void> getOverview() async {
    var url = Uri.parse(Url.getOverview);
    var res = await http.post(url);
    List<dynamic> data = json.decode(res.body);
    for (int i = 0; i < data.length; i++) {
      _listOverview.add(data[i]);
    }
  }
}
