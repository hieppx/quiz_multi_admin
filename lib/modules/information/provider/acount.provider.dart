// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_multi_admin/service/account.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../../models/account.dart';

class AccountModel extends ChangeNotifier {
  AccountRepo accountRepo = AccountRepo();

  User _userLogin = User();
  User get userLogin => _userLogin;

  bool? _isDupicate;
  bool? get isDupicate => _isDupicate;

  final List<User> _users = [];
  List<User> get users => _users;

  TextEditingController? _username;
  TextEditingController? get username => _username;

  TextEditingController? _password;
  TextEditingController? get password => _password;

  TextEditingController? _fullName;
  TextEditingController? get fullName => _fullName;

  final TextEditingController _usernameInsert = TextEditingController();
  TextEditingController get usernameInsert => _usernameInsert;

  final TextEditingController _passwordInsert = TextEditingController();
  TextEditingController get passwordInsert => _passwordInsert;

  final TextEditingController _fullNameInsert = TextEditingController();
  TextEditingController get fullNameInsert => _fullNameInsert;

  final TextEditingController _passwordReset = TextEditingController();
  TextEditingController get passwordReset => _passwordReset;

  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userlogin');
    List<User> tmp = [];
    tmp = await accountRepo.getUser(userName!);
    for (int i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _userLogin = item;
    }
    _username = TextEditingController(text: userName);
    _password = TextEditingController(text: _userLogin.password);
    _fullName = TextEditingController(text: _userLogin.fullName);
    notifyListeners();
  }

  void updateUser() async {
    await accountRepo.updateUser(_username!.text, _password!.text,
        _fullName!.text, _username!.text == 'admin' ? '0' : '1');
    notifyListeners();
  }

  void getUsers() async {
    List<User> tmp = [];
    tmp = await accountRepo.getUsers();
    for (int i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _users.add(item);
    }
    notifyListeners();
  }

  void deleteUser(String username) async {
    _users.removeWhere((element) => element.userName == username);
    await accountRepo.deleteUser(username);
    notifyListeners();
  }

  void resetValue() {
    _usernameInsert.clear();
    _passwordInsert.clear();
    _fullNameInsert.clear();
    notifyListeners();
  }

  void insertUser() async {
    await accountRepo.insertUser(
        _usernameInsert.text, _passwordInsert.text, _fullNameInsert.text);
    _isDupicate = accountRepo.isDupicate;
    if (_isDupicate == false) {
      _users.add(User(
          userName: _usernameInsert.text,
          password: _passwordInsert.text,
          fullName: _fullNameInsert.text));
    } else {}

    notifyListeners();
  }

  void resetPassword(String username) async {
    await accountRepo.resetPassword(_passwordReset.text, username);
    _passwordReset.clear();
    notifyListeners();
  }
}
