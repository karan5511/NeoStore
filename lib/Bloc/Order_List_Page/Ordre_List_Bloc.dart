import 'package:bloc/bloc.dart';
import 'package:neo_store/Bloc/Order_List_Page/Ordre_List_Event.dart';
import 'package:neo_store/Bloc/Order_List_Page/Ordre_List_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/orders_repo.dart';
import 'package:neo_store/model/order_List_model.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListRepo orderListRepo;

  OrderListBloc({this.orderListRepo}) : super(OrderListState());

  @override
  Stream<OrderListState> mapEventToState(OrderListEvent event) async* {
    if (event is OnMyOrdersClicked) {
      yield state.copyWith(
          accessToken: event.accessToken, orderList: event.orderList);

      try {
        OrderList order =
            await orderListRepo.getOrderList(accessToken: event.accessToken);
        if (order.status == 200) {
          print("Success");
          yield state.copyWith(orderList: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(orderList: SubmissionFailure(e));
      }
    }
  }
}
