import 'package:neo_store/model/order_Detail_model.dart';
import 'package:http/http.dart' as http;

class OrderDetailsRepository {
  Future<OrderDetail> getOrderDetails(
      {String accessToken, String orderId}) async {
    var endPointUrl =
        "http://staging.php-dev.in:8844/trainingapp/api/orderDetail";
    Map<String, String> queryParams = {
      "order_id": orderId.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = endPointUrl + "?" + queryString;
    var response = await http.get(Uri.parse(requestUrl), headers: {
      "access_token": accessToken,
    });

    if (response.statusCode == 200) {
      final responseJson = orderDetailFromJson(response.body);
      print('accountDetailsFromJson');
      print(responseJson);
      print(response.body);
      return responseJson;
    } else {
      final responseJson = orderDetailFromJson(response.body);
      print(responseJson);
      return responseJson;
    }
  }
}
