import 'package:flutter/material.dart';
import 'package:quiz_multi_admin/modules/home/screen/home.screen.dart';

import 'common/routes.dart';
import 'common/titles.dart';
import 'common/widget/menu/left_menu.dart';
import 'common/widget/menu/vertical_tabbar.dart';
import 'common/widget/responsive/responsive_container.dart';
import 'modules/dashboard/screen/overview.screen.dart';
import 'modules/information/screen/information.screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String _currentRoute = kHome;
  void _onChangedTabBar(String route) {
    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      large: Scaffold(
        body: Row(
          children: [
            VerticalTabBar(
                selectedRoute: _currentRoute, onChanged: _onChangedTabBar),
            Expanded(child: _buildContent(context))
          ],
        ),
      ),
      small: Scaffold(
          appBar: _enableMainAppBar()
              ? AppBar(
                  title: Text(
                    getTitleByRoute(_currentRoute, context),
                  ),
                  centerTitle: true,
                )
              : null,
          drawer: LeftMenu(onChanged: _onChangedTabBar),
          body: _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_currentRoute) {
      case kHome:
        return const HomePage();
      case kAccount:
        return const InformationPage();
      case kDashboard:
        return const OverviewPage();
      default:
        return Center(
          child: Text('No content for $_currentRoute'),
        );
    }
  }

  bool _enableMainAppBar() {
    switch (_currentRoute) {
      case kHome:
      case kAccount:
      case kDashboard:
        return true;
      default:
        return false;
    }
  }
}
