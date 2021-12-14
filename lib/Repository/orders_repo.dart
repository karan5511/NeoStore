import 'package:neo_store/model/order_List_model.dart';
import 'package:http/http.dart' as http;
class OrderListRepo{
  Future<OrderList> getOrderList({String accessToken}) async {
    final url =
        'http://staging.php-dev.in:8844/trainingapp/api/orderList';

    final response =
    await http.get(Uri.parse(url), headers: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final responseJson = orderListFromJson(response.body);
      print('accountDetailsFromJson');
      print(responseJson);
      return responseJson;
    } else {
      final responseJson = orderListFromJson(response.body);
      print(responseJson);
      return responseJson;
    }
  }
}