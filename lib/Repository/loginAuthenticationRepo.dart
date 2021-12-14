import 'dart:convert';
import 'package:neo_store/model/Register_model.dart';
import 'package:http/http.dart' as http;

class LoginAuthRepository {
  static Future<RegisterResponseModel> login(
      String username, String passw) async {
    final _url = 'http://staging.php-dev.in:8844/trainingapp/api/users/login';
    print(_url);
    final response = await http.post(Uri.parse(_url), body: {
      "email": username,
      "password": passw,
    });
    print(response.body);
    int responseCode = response.statusCode;
    final json = jsonDecode(response.body);
    print(response.body);
    if (responseCode == 200) {
      return RegisterResponseModel.fromJson(json);
    } else {
      return RegisterResponseModel.fromJson(json);
    }
  }
}
