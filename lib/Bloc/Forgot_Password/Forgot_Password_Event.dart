import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class ForgotPasswordEvent {}

class ForgotPasswordSend extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordSend(this.email);
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  FormSubmissionState loginSubmit;

  String email;

  ForgotPasswordSubmitted({
    this.email,
  });
}
