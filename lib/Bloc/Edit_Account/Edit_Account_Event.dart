import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class EditAccountEvent {}

class OnFirstNameChanged extends EditAccountEvent {
  String firstName;

  OnFirstNameChanged({this.firstName});
}

class OnLastNameChanged extends EditAccountEvent {
  String lastName;

  OnLastNameChanged({this.lastName});
}

class OnEmailChanged extends EditAccountEvent {
  String email;

  OnEmailChanged({this.email});
}

class OnPhoneNoChanged extends EditAccountEvent {
  String phoneNo;

  OnPhoneNoChanged({this.phoneNo});
}

class OnDobChanged extends EditAccountEvent {
  String dob;

  OnDobChanged({this.dob});
}

class OnProfilePicChanged extends EditAccountEvent {
  String profilePic;

  OnProfilePicChanged({this.profilePic});
}

class OnSubmitClick extends EditAccountEvent {
  FormSubmissionState editSubmit;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String dob;
  String profilePic;
  String accessToken;

  OnSubmitClick(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.dob,
      this.profilePic,
      this.editSubmit,
      this.accessToken});
}
