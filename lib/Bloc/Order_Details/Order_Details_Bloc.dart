import 'package:bloc/bloc.dart';
import 'package:neo_store/Bloc/Order_Details/Order_Details_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/OrderDetailsRepo.dart';
import 'package:neo_store/model/order_Detail_model.dart';

import 'Order_Details_Event.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsRepository orderDetailRepo;

  OrderDetailsBloc({this.orderDetailRepo}) : super(OrderDetailsState());

  @override
  Stream<OrderDetailsState> mapEventToState(OrderDetailsEvent event) async* {
    if (event is OnOrderDetailsClicked) {
      yield state.copyWith(
          orderDetail: event.orderDetail,
          accessToken: event.accessToken,
          id: event.id);

      try {
        OrderDetail orderdet = await orderDetailRepo.getOrderDetails(
            accessToken: event.accessToken, orderId: event.id);
        if (orderdet.status == 200) {
          print("Success");
          yield state.copyWith(orderDetail: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(orderDetail: SubmissionFailure(e));
      }
    }
  }
}
