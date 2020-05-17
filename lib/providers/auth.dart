import 'package:flutter/widgets.dart';
import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  String get userID{
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) return _token;
        return null;
  }

  Future<void> _authenticate(
      String email, String password, String value) async {
    try {
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:$value?key=AIzaSyAmVdlNZxGewTrJIIsZ_nENOA9hbZlx2xY ';

      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      //print(responseData);
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      //print(_userId);
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autologout();
      notifyListeners();
    } catch (error) {
      //print(error.toString());
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout()
  {
    _userId =null;
    _token =null;
    _expiryDate =null;
    if(_authTimer!=null)
    {
      _authTimer.cancel();
      _authTimer =null;
    }
    notifyListeners();
  }

  void _autologout()
  {
    if(_authTimer!=null)
    {
        _authTimer.cancel();
    }
    final _timeToExpiry =_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer =Timer(Duration(seconds: _timeToExpiry),logout);

  }
}
