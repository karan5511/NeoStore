import 'package:bloc/bloc.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_Event.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/cart_repo.dart';
import 'package:neo_store/model/cart_list_model.dart';
import 'package:neo_store/model/my_cart_model.dart';

class CartListBloc extends Bloc<CartListEvent, CartState> {
  CartAuthRepository cartRepo;

  CartListBloc({this.cartRepo}) : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartListEvent event) async* {
    if (event is OnShowCartList) {
      yield state.copyWith(accessToken: event.accessToken);

      try {
        CartItems cartItems = await cartRepo.getCartList(event.accessToken);
        if (cartItems.status == 200) {
          print("Success");
          yield state.copyWith(cartEditted: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(cartEditted: SubmissionFailure(e));
      }
    } else if (event is OnDropDownPressed) {
      yield state.copyWith(
          accessToken: event.accessToken,
          quantity: event.quantity,
          productId: event.productId);

      try {
        Cart cart = await cartRepo.editCartData(
            event.accessToken, event.productId, event.quantity);
        if (cart.status == 200) {
          print("Success");
          yield state.copyWith(cartEditted: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(cartEditted: SubmissionFailure(e));
      }
    } else if (event is OnDeleteSwiped) {
      yield state.copyWith(
          accessToken: event.accessToken, productId: event.productId);

      try {
        Cart cartdel =
            await cartRepo.deleteCartData(event.accessToken, event.productId);
        if (cartdel.status == 200) {
          print("Success");
          yield state.copyWith(cartEditted: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(cartEditted: SubmissionFailure(e));
      }
    }
  }
}
