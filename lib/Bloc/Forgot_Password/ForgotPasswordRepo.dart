import 'dart:convert';

import 'package:neo_store/model/Register_model.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordAuthRepository {
  static Future<RegisterResponseModel> forgotPassword(String email) async {
    final _url = 'http://staging.php-dev.in:8844/trainingapp/api/users/forgot';
    print(_url);
    final response = await http.post(Uri.parse(_url), body: {
      "email": email,
    });
    print(response);
    int responseCode = response.statusCode;
    final json = jsonDecode(response.body);

    if (responseCode == 200) {
      return RegisterResponseModel.fromJson(json);
    }
  }
}
