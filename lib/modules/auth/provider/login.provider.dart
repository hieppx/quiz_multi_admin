import 'package:flutter/material.dart';
import 'package:quiz_multi_admin/service/account.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController _userName = TextEditingController();
  TextEditingController get userName => _userName;

  final TextEditingController _password = TextEditingController();
  TextEditingController get password => _password;

  AccountRepo accountRepo = AccountRepo();

  bool? _isLogin;
  bool? get isLogin => _isLogin;
  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userlogin', _userName.text);
    if(_userName.text == 'admin'){
       prefs.setInt('role',0);
    }else{
       prefs.setInt('role',1);
    }
    await accountRepo.login(_userName.text, _password.text);
    _isLogin = accountRepo.isLogin;
    notifyListeners();
  }
}
