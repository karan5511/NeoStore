import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class ResetPasswordState {
  String currentPassword;
  String newPassword;
  String confirmNewPassword;
  String accessToken;
  FormSubmissionState resetPass;
  ResetPasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.accessToken = '',
    this.resetPass = const InitialState(),
  });

  ResetPasswordState copyWith({
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
    String accessToken,
    FormSubmissionState resetPass,
  }) {
    return ResetPasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      accessToken: accessToken ?? this.accessToken,
      resetPass: resetPass ?? this.resetPass,
    );
  }
}
