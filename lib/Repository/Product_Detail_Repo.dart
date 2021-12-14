import 'dart:convert';

import 'package:neo_store/model/Product_Details_model.dart';
import 'package:http/http.dart' as http;

class ProductDetailsAuthRepo {
  Future<ProductDetail> getProductDetail(String productId) async {
    final parameters = {
      'product_id': productId,
    };

    var url =
        ('http://staging.php-dev.in:8844/trainingapp/api/products/getDetail');

    String query = Uri(queryParameters: parameters).query;
    final requestUrl = url + "?" + query;
    final response = await http.get(Uri.parse(requestUrl));
    final jsonData = response.body;
    final res = productDetailFromJson(response.body);
    print(jsonDecode(jsonData));
    return res;
  }
}
