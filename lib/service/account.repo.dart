import 'package:quiz_multi_admin/models/account.dart';

import '../common/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountRepo {
  bool? _isLogin;
  bool? get isLogin => _isLogin;

  bool? _isDupicate;
  bool? get isDupicate => _isDupicate;

  Future<void> login(String userName, String password) async {
    var url = Uri.parse(Url.login);
    var response = await http.post(url, body: {
      "username": userName,
      "password": password,
    });
    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
  }

  Future<List<User>> getUser(String userName) async {
    var url = Uri.parse(Url.getUser);
    var res = await http.post(url, body: {"username": userName});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<List<User>> getUsers() async {
    var url = Uri.parse(Url.getUsers);
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> updateUser(
      String userName, String password, String fullname, String role) async {
    var url = Uri.parse(Url.updateUser);
    await http.post(url, body: {
      "username": userName,
      "password": password,
      "fullname": fullname,
      "role": role
    });
  }

  Future<void> insertUser(
      String userName, String password, String fullname) async {
    var url = Uri.parse(Url.insertUser);
    var res = await http.post(url,
        body: {"username": userName, "password": password, "name": fullname});

    var data = json.decode(res.body);
    if (data == 'Success') {
      _isDupicate = false;
    } else {
      _isDupicate = true;
    }
  }

  Future<void> deleteUser(String userName) async {
    var url = Uri.parse(Url.deleteUser);
    await http.post(url, body: {
      "username": userName,
    });
  }

  Future<void> resetPassword(String password, String username) async {
    var url = Uri.parse(Url.resetPassword);
    await http.post(url, body: {"username": username, "password": password});
  }
}
