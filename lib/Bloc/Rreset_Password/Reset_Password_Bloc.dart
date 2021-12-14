import 'package:bloc/bloc.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/Reset_Password_Repo.dart';
import 'package:neo_store/model/Register_model.dart';
import 'Reset_Password_Event.dart';
import 'Reset_Password_State.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordRepo ResetPasswordAuthRepo;

  ResetPasswordBloc({this.ResetPasswordAuthRepo}) : super(ResetPasswordState());

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is OnCurrentPasswordChanged) {
      yield state.copyWith(currentPassword: event.currentPassword);
    } else if (event is OnNewPasswordChanged) {
      yield state.copyWith(newPassword: event.newPassword);
    } else if (event is OnConfirmNewPasswordChanged) {
      yield state.copyWith(confirmNewPassword: event.confirmNewPassword);
    } else if (event is ResetSubmitted) {
      yield state.copyWith(
          newPassword: event.newPassword,
          currentPassword: event.currentPassword,
          confirmNewPassword: event.confirmNewPassword,
          accessToken: event.accessToken);

      try {
        RegisterResponseModel resetPassword =
            await ResetPasswordAuthRepo.resetData(
                event.accessToken,
                event.currentPassword,
                event.newPassword,
                event.confirmNewPassword);
        if (resetPassword.status == 200) {
          print("Success");
          yield state.copyWith(resetPass: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(resetPass: SubmissionFailure(e));
      }
    }
  }
}
