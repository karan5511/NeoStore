import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class ResetPasswordEvent {}

class OnCurrentPasswordChanged extends ResetPasswordEvent {
  final String currentPassword;
  OnCurrentPasswordChanged({
    this.currentPassword,
  });
}

class OnNewPasswordChanged extends ResetPasswordEvent {
  final String newPassword;
  OnNewPasswordChanged({this.newPassword});
}

class OnConfirmNewPasswordChanged extends ResetPasswordEvent {
  final String confirmNewPassword;
  OnConfirmNewPasswordChanged({this.confirmNewPassword});
}

class ResetSubmitted extends ResetPasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final String accessToken;
  FormSubmissionState resetPass;

  ResetSubmitted({
    this.currentPassword,
    this.newPassword,
    this.confirmNewPassword,
    this.resetPass,
    this.accessToken,
  });
}
