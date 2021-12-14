import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/model/Register_model.dart';

class LoginState {
  final String username;
  final String password;
  RegisterResponseModel loginModel;

  final FormSubmissionState loginSubmit;

  LoginState({
    this.username = '',
    this.password = '',
    this.loginModel,
    this.loginSubmit = const InitialState(),
  });

  LoginState copyWith({
    String username,
    String password,
    RegisterResponseModel loginModel,
    FormSubmissionState loginSubmit,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      loginSubmit: loginSubmit ?? this.loginSubmit,
      loginModel: loginModel ?? this.loginModel,
    );
  }
}
