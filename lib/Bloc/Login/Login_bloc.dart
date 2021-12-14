import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Login/Login_Event.dart';
import 'package:neo_store/Bloc/Login/Login_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/loginAuthenticationRepo.dart';
import 'package:neo_store/model/Register_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginAuthRepository loginAuthRepo;

  LoginBloc({this.loginAuthRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(
          username: event.username,
          password: event.password,
          loginSubmit: FormSubmittingState());

      try {
        RegisterResponseModel loginUser =
            await LoginAuthRepository.login(event.username, event.password);
        print(loginUser);
        if (loginUser.status == 200) {
          print("Success");
          yield state.copyWith(loginSubmit: SubmissionSuccess());
          yield state.copyWith(loginModel: loginUser);
        }
      } on Exception catch (e) {
        print(e);
        yield state.copyWith(loginSubmit: SubmissionFailure(e));
      }
    }
  }
}
