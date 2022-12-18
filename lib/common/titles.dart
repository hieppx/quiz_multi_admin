import 'package:flutter/widgets.dart';

import '../generated/l10n.dart';
import 'routes.dart';

String getTitleByRoute(String route, BuildContext context) {
  switch (route) {
    case kHome:
      return S.of(context).labelHome;
    case kAccount:
      return S.of(context).labelInformation;
      case kDashboard:
      return S.of(context).overview;
    default:
      return 'No title';
  }
}
