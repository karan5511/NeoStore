import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class AddressEvent {
  const AddressEvent();
}

class OnAddressChanged extends AddressEvent {
  final String address;
  final String accessToken;
  OnAddressChanged({this.address, this.accessToken});
}

class onPlaceOrderClicked extends AddressEvent {
  FormSubmissionState addressSubmit;
  String accessToken;
  String address;

  onPlaceOrderClicked({this.address, this.accessToken});
}
