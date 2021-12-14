import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class ProductDetailState {
  int total_carts = 0;
  FormSubmissionState addToCart;

  ProductDetailState({
    this.addToCart,
    this.total_carts,
  });
}
