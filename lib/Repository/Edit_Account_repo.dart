import 'package:neo_store/model/Register_model.dart';
import 'package:http/http.dart' as http;

class EditAccRepo {
  Future<RegisterResponseModel> addData(
    String accessToken,
    String dob,
    String profile_pic,
    String email,
    String phone_no,
    String firstName,
    String lastName,
  ) async {
    var url = Uri.parse(
        'http://staging.php-dev.in:8844/trainingapp/api/users/update');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'dob': dob,
      'profile_pic': profile_pic,
      'email': email,
      'phone_no': phone_no,
      'first_name': firstName,
      'last_name': lastName,
    });
    print(response.body);
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
