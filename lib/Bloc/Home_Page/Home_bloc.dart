import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Home_Page/Home_Event.dart';
import 'package:neo_store/Bloc/Home_Page/Home_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/HomeAuthenticationRepo.dart';
import 'package:neo_store/model/Product_List_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeAuthRepo homeAuthRepo;

  HomeBloc({this.homeAuthRepo}) : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OnHomeButtonClicked) {
      yield state.copyWith(homepageSubmit: event.homepageSubmit);

      try {
        ProductListResponseModel productList =
            await homeAuthRepo.getProductList(event.id);
        if (productList.status == 200) {
          print("Success");
          yield state.copyWith(homepageSubmit: SubmissionSuccess());
          yield state.copyWith(product: productList);
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(homepageSubmit: SubmissionFailure(e));
      }
    }
  }
}
