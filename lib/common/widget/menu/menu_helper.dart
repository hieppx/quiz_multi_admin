import 'package:quiz_multi_admin/common/routes.dart';

import '../../images.dart';

List<String> get menuRouteAdmin {
  return [kHome, kAccount, kDashboard];
}

List<String> get menuRouteNoAdmin {
  return [kHome, kAccount];
}

String getMenuIconByRouteAdmin(String route) {
  switch (route) {
    case kHome:
      return iconTabBarHome;
    case kAccount:
      return iconTabBarUsers;
    case kDashboard:
      return iconDashboard;
    default:
      return '';
  }
}

String getMenuIconByRouteNoAdmin(String route) {
  switch (route) {
    case kHome:
      return iconTabBarHome;
    case kAccount:
      return iconTabBarUsers;
    default:
      return '';
  }
}
