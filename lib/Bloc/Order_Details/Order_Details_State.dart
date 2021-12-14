import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/model/order_Detail_model.dart';

class OrderDetailsState {
  OrderDetail orderDets;
  final FormSubmissionState orderDetail;
  String accessToken;
  String id;

  OrderDetailsState(
      {this.orderDets, this.orderDetail, this.accessToken, this.id});

  OrderDetailsState copyWith({
    OrderDetail orderDets,
    FormSubmissionState orderDetail,
    String accessToken,
    String id,
  }) {
    return OrderDetailsState(
        accessToken: accessToken ?? this.accessToken,
        orderDets: orderDets ?? this.orderDets,
        orderDetail: orderDetail ?? this.orderDetail,
        id: id ?? this.id);
  }
}
