import 'package:neo_store/model/Register_model.dart';
import 'package:http/http.dart' as http;

class ResetPasswordRepo {
  Future<RegisterResponseModel> resetData(String accessToken,
      String currentPass, String newPass, String confirmPass) async {
    var url = Uri.parse(
        'http://staging.php-dev.in:8844/trainingapp/api/users/change');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'old_password': currentPass,
      'password': newPass,
      'confirm_password': confirmPass,
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
