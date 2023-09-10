import 'dart:convert';
import 'package:contactly/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _uid = "";
  String _password = "";
  String _token = "";
  String name = "";
  String email = "";
  bool isAuth = false;
  bool checked = false;

  Future<bool> autologin() async {
    var data = await SharedPreferences.getInstance();
    List<String>? m = data.getStringList('data');
    print("this is running");
    print(m);
    if (m == null || m == []) {
      return false;
    } else {
      _uid = m[0];
      _password = m[1];
      _token = m[2];
      name = m[3];
      isAuth = true;
      checked = true;
      notifyListeners();
      return true;
    }
  }

  String get token {
    return _token.toString();
  }

  String get uid {
    return _uid.toString();
  }

  Future<void> _authenticateLogin(
      String username, String pass, String keyword) async {
    print(username + pass + keyword);
    print('this code is running');
    try {
      print('wait');
      final url = Uri.https("contactapp-d93h.onrender.com", '/$keyword/',
          {'id': username, 'password': pass});
      print(url.toString());
      final response = await http.get(url);
      // print('done');
      print(response.body);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        print(responseData['message']);
        name = responseData['name'];
        _uid = username;
        _password = pass;
        _token = responseData['token'];
        var pref = await SharedPreferences.getInstance();
        pref.setStringList('data', [_uid, _password, _token, name]);
        isAuth = true;
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future<void> login(String uid, String pass) async {
    await _authenticateLogin(uid, pass, "login");
  }

  Future<void> _authenticateSignUp(
      String uid, String pass, String email, String name) async {
    print("This code is running");
    try {
      final url = Uri.https("contactapp-d93h.onrender.com", "/signup/",
          {"id": uid, "password": pass, "name": name, "email": email});
      print(url);
      final response = await http.get(url);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(response.body);
      if (responseData['status'] == false) {
        throw HttpException(responseData['msg']);
      }
      var pref = await SharedPreferences.getInstance();
      pref.setStringList('data', [_uid, _password, _token, name]);
      isAuth = true;
      notifyListeners();
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future<void> signUp(
      String uid, String pass, String email, String name) async {
    await _authenticateSignUp(uid, pass, email, name);
  }

  void logout() async {
    _password = "";
    _token = "";
    _uid = "";
    name = "";
    email = "";
    isAuth = false;
    var pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }
}
