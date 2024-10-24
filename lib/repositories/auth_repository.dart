import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<void> login({required String email, required String password}) async {
    var login = Uri.parse('user-login/');
    Uri url = Uri.parse('http://learningapp.e8demo.com/api/$login');
    Map<String, dynamic> data = {'email': email, 'password': password};
    Response response = await post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['result'] == 'failure') {
        if (jsonResponse.containsKey('errors')) {
          Map<String, dynamic> errors = jsonResponse['errors'];
          if (errors.containsKey('email')) {
            throw LoginFailureException(emailError: errors['email']);
          } else if (errors.containsKey('password')) {
            throw LoginFailureException(passwordError: errors['password']);
          }
        }
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool('isLogged', true);
        sharedPreferences.setString(
            'token', jsonResponse['token']['access_token']);
      }
    } else {
      throw Exception();
    }
  }
}

class LoginFailureException implements Exception {
  final String? emailError;
  final String? passwordError;
  LoginFailureException({this.emailError, this.passwordError});
}
