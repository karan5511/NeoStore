import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/model/order_List_model.dart';

class OrderListState {
  OrderList order;
  final FormSubmissionState orderList;
  String accessToken;

  OrderListState({this.order, this.orderList, this.accessToken});

  OrderListState copyWith(
      {OrderList order, FormSubmissionState orderList, String accessToken}) {
    return OrderListState(
      accessToken: accessToken ?? this.accessToken,
      order: order ?? this.order,
      orderList: orderList ?? this.orderList,
    );
  }
}
