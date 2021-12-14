import 'package:neo_store/model/order_model.dart';
import 'package:http/http.dart' as http;

class AddressAuthRepository {
  Future<Order> addAddress(String accessToken, String address) async {
    var url = Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/order');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'address': address,
    });
    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = orderFromJson(response.body);

      print(response.body);

      return jsonBody;
    } else {
      final jsonBody = orderFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }
}
