import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class AddressState {
  final String address;
  final String accessToken;
  final FormSubmissionState addressSubmit;

  AddressState({
    this.address = '',
    this.accessToken = '',
    this.addressSubmit = const InitialState(),
  });

  AddressState copyWith(
      {final String address,
      final String accessToken,
      final FormSubmissionState addressSubmit}) {
    return AddressState(
        address: address ?? this.address,
        accessToken: accessToken ?? this.accessToken,
        addressSubmit: addressSubmit ?? this.addressSubmit);
  }
}
