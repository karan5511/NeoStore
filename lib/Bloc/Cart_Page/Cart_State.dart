import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class CartState {
  final String accessToken;
  final String productId;
  final String quantity;
  final FormSubmissionState cartEditted;

  CartState({
    this.accessToken = '',
    this.productId = '',
    this.quantity = '',
    this.cartEditted = const InitialState(),
  });

  CartState copyWith(
      {final String accessToken,
      final String productId,
      final String quantity,
      final FormSubmissionState cartEditted}) {
    return CartState(
        accessToken: accessToken ?? this.accessToken,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        cartEditted: cartEditted ?? this.cartEditted);
  }
}
