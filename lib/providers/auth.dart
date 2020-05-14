import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(String email,String password,String value) async
  {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$value?key=AIzaSyAmVdlNZxGewTrJIIsZ_nENOA9hbZlx2xY ';

    final response = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
  }

  Future<void> signup(String email, String password) async {
     return _authenticate(email, password,'signUp');
  }

  Future<void> login(String email, String password) async {    
     return _authenticate(email, password,'signInWithPassword');
  }

}