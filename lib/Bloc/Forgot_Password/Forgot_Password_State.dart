import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class ForgotPasswordState {
  final String email;
  final FormSubmissionState forgotPasswordSubmit;

  ForgotPasswordState({
    this.email = '',
    this.forgotPasswordSubmit = const InitialState(),
  });

  ForgotPasswordState copyWith(
      {String email, FormSubmittingState forgotPasswordState}) {
    return ForgotPasswordState(
      email: email ?? this.email,
      forgotPasswordSubmit: forgotPasswordState ?? this.forgotPasswordSubmit,
    );
  }
}
