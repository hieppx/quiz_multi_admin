import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../routes.dart';
import '../../titles.dart';
import '../drop.down.dart';
import '../switch.dart';
import 'menu_helper.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({Key? key, required this.onChanged}) : super(key: key);
  final Function(String) onChanged;

  @override
  State<LeftMenu> createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role');
      if (role == 0) {
        roles = menuRouteAdmin;
      }else{
        roles = menuRouteNoAdmin;
      }
    });
  }

  int? role;

  List<String> roles = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Image.asset('assets/logo.png'),
        ),
        ...roles
            .map((e) => ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(getTitleByRoute(e, context)),
                  ),
                  onTap: () {
                    widget.onChanged(e);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: ListTile(
            title: Text(S.of(context).language),
            trailing: const Language(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: ListTile(
            title: Text(S.of(context).appearance),
            trailing: const SwitchButton(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: ListTile(
            title: Text(S.of(context).logout),
            onTap: _logout,
          ),
        ),
      ],
    ));
  }

  void _logout() {
    Navigator.of(context).pushReplacementNamed(kLogin);
  }
}
