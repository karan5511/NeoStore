import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/model/Product_List_model.dart';

class HomeState {
  ProductListResponseModel product;
  final FormSubmissionState homepageSubmit;

  HomeState({this.product, this.homepageSubmit});

  HomeState copyWith({
    ProductListResponseModel product,
    FormSubmissionState homepageSubmit,
  }) {
    return HomeState(
      product: product ?? this.product,
      homepageSubmit: homepageSubmit ?? this.homepageSubmit,
    );
  }
}
