import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Address_Page/Address_Event.dart';
import 'package:neo_store/Bloc/Address_Page/Address_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/Add_Address_Repo.dart';
import 'package:neo_store/model/order_model.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressAuthRepository addressRepo;

  AddressBloc({this.addressRepo}) : super(AddressState());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    if (event is OnAddressChanged) {
      yield state.copyWith(address: event.address);
    } else if (event is onPlaceOrderClicked) {
      yield state.copyWith(
          address: event.address,
          addressSubmit: event.addressSubmit,
          accessToken: event.accessToken);

      try {
        Order addressOrder =
            await addressRepo.addAddress(event.address, event.accessToken);
        print("address bloc");
        if (addressOrder.status == 200) {
          print("Success");
          yield state.copyWith(addressSubmit: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print(e);
        yield state.copyWith(addressSubmit: SubmissionFailure(e));
      }
    }
  }
}
