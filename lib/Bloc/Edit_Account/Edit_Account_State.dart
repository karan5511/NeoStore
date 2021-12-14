import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class EditAccountState {
  final String firstName;
  final String lastName;
  final String email;

  final String dob;
  final dynamic phoneNumber;
  final String profilePic;
  String accessToken;
  final FormSubmissionState editSubmit;

  EditAccountState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.profilePic = '',
    this.dob = '',
    this.phoneNumber = '',
    this.accessToken = '',
    this.editSubmit = const InitialState(),
  });

  EditAccountState copyWith({
    String firstName,
    String lastName,
    String email,
    String profilePic,
    String dob,
    dynamic phoneNo,
    String accessToken,
    FormSubmissionState editSubmit,
  }) {
    return EditAccountState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accessToken: accessToken ?? accessToken,
      editSubmit: editSubmit ?? editSubmit,
    );
  }
}
