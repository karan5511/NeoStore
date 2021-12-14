import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Product_Details/Product_Details_State.dart';
import 'package:neo_store/Bloc/Product_Details/Product_Details_event.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

import 'package:neo_store/Repository/add_to_cart.dart';

import 'package:neo_store/model/my_cart_model.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  AddToCartRepo addToCartRepo;

  ProductDetailBloc({this.addToCartRepo}) : super(ProductDetailState());

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is buyNowButtonPressed) {
      yield ProductDetailState(addToCart: FormSubmittingState());
      try {
        Cart myCart =
            await addToCartRepo.addCartData(event.token, event.id, event.quant);

        print('event.quant ${event.quant}');
        await Future.delayed(Duration(seconds: 2));
        yield ProductDetailState(addToCart: FormSubmittingState());
      } on Exception catch (e) {}
    }
  }
}
