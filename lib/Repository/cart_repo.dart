import 'package:neo_store/model/cart_list_model.dart';
import 'package:neo_store/model/my_cart_model.dart';
import 'package:http/http.dart' as http;

class CartAuthRepository {
  Future<CartItems> getCartList(String accessToken) async {
    var url = ('http://staging.php-dev.in:8844/trainingapp/api/cart');

    final response =
        await http.get(Uri.parse(url), headers: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final responseJson = cartItemsFromJson(response.body);
      print('cartDetails');
      print(responseJson);
      return responseJson;
    } else {
      final responseJson = cartItemsFromJson(response.body);
      print(responseJson);
      return responseJson;
    }
  }

  Future<Cart> editCartData(
      String accessToken, String quants, String id) async {
    var url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/editCart');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'product_id': id,
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

  Future<Cart> deleteCartData(String accessToken, String id) async {
    var url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/deleteCart');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'product_id': id,
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
