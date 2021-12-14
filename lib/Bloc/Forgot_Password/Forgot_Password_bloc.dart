import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neo_store/Bloc/Forgot_Password/Forgot_Password_Event.dart';
import 'package:neo_store/Bloc/Forgot_Password/Forgot_Password_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/model/Register_model.dart';

import 'ForgotPasswordRepo.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordAuthRepository forgotPasswordAuthRepo;

  ForgotPasswordBloc({this.forgotPasswordAuthRepo})
      : super(ForgotPasswordState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordSend) {
      yield state.copyWith(email: event.email);
    } else if (event is ForgotPasswordSubmitted) {
      yield state.copyWith(email: event.email);

      try {
        RegisterResponseModel forgot =
            await ForgotPasswordAuthRepository.forgotPassword(event.email);
        if (forgot.status == 200) {
          print("Success");
          yield state.copyWith(forgotPasswordState: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(forgotPasswordState: SubmissionFailure(e));
      }
    }
  }
}
