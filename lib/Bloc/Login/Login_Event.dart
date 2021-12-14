import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({this.password});
}

class LoginSubmitted extends LoginEvent {
  FormSubmissionState loginSubmit;

  String username;
  String password;

  LoginSubmitted({
    this.username,
    this.password,
  });
}
