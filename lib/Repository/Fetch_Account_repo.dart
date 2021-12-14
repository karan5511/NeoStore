import 'dart:convert';
import 'package:neo_store/model/Fetch_Account_Model.dart';
import 'package:http/http.dart' as http;

class AccDetailsRepo {
  Future<AccountDetails> getAccountDetails({String accessToken}) async {
    final url =
        'http://staging.php-dev.in:8844/trainingapp/api/users/getUserData';

    final response =
        await http.get(Uri.parse(url), headers: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final responseJson = accountDetailsFromJson(response.body);
      print('accountDetailsFromJson');
      print(responseJson);
      return responseJson;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      return responseJson;
    }
  }
}
