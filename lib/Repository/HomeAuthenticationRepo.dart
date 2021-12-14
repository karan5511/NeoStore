import 'package:neo_store/model/Product_List_model.dart';
import 'package:http/http.dart' as http;

class HomeAuthRepo {
  int pageNumber = 1;
  Future<ProductListResponseModel> getProductList(String productType) async {
    final Map<String, String> productTypes = {
      "tables": "1",
      "chairs": "2",
      "sofas": "3",
      "cupboards": "4",
    };
    final parameters = {
      'product_category_id': productTypes[productType],
      'limit': '10',
      'page': pageNumber.toString()
    };

    var url =
        ('http://staging.php-dev.in:8844/trainingapp/api/products/getList');
    print(url);
    String query = Uri(queryParameters: parameters).query;
    final requestUrl = url + "?" + query;
    final response = await http.get(Uri.parse(requestUrl));
    final jsonData = response.body;
    final res = productFromJson(response.body);
    print(res);
    return res;
  }
}
