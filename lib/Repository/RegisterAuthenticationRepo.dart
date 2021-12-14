import 'package:http/http.dart' as http;
import 'package:neo_store/model/Register_model.dart';

class RegisterAuthRepository {
  Future<RegisterResponseModel> addData(
      String firstName,
      String lastName,
      String email,
      String password,
      String confirmPassword,
      String gender,
      String phoneNo) async {
    var url = Uri.parse(
        'http://staging.php-dev.in:8844/trainingapp/api/users/register');
    print(url);
    final response = await http.post(url, body: {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'gender': gender,
      'phone_no': phoneNo,
    });

    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = userFromJson(response.body);

      print(response.body);

      return jsonBody;
    } else {
      final jsonBody = userFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }
}
