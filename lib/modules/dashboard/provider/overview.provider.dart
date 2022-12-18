import 'package:flutter/cupertino.dart';

import 'package:quiz_multi_admin/service/overview.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewModel extends ChangeNotifier {
  OverviewRepo repo = OverviewRepo();

  Future getOverview() async {
    await repo.getOverview();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listOverView', repo.listOverview);
    notifyListeners();
  }
}
