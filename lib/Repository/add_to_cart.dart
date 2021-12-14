import 'package:neo_store/model/my_cart_model.dart';
import 'package:http/http.dart' as http;

class AddToCartRepo {
  Future<Cart> addCartData(String accessToken, String quants, String id) async {
    var url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/addToCart');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'product_id': id.toString(),
      'quantity': quants,
    });
    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = cartFromJson(response.body);

      print(response.body);

      return jsonBody;
    } else {
      final jsonBody = cartFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }
}
