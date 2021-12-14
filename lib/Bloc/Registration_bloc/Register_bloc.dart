import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Event.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_State.dart';
import 'package:neo_store/Repository/RegisterAuthenticationRepo.dart';
import 'package:neo_store/model/Register_model.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterAuthRepository registerAuthRepo;
  // UserData userData;

  RegisterBloc({this.registerAuthRepo}) : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is RegisterLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is RegisterEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    } else if (event is RegisterGenderChanged) {
      yield state.copyWith(gender: event.gender);
    } else if (event is RegisterPhoneNumberChanged) {
      yield state.copyWith(phoneNo: event.phoneNo);
    } else if (event is RegisterSubmitted) {
      yield state.copyWith(
        registerSubmit: FormSubmittingState(),
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        gender: event.gender,
        phoneNo: event.phoneNumber,
      );

      try {
        RegisterResponseModel registerModel = await registerAuthRepo.addData(
          event.firstName,
          event.lastName,
          event.email,
          event.password,
          event.confirmPassword,
          event.gender,
          event.phoneNumber,
        );

        if (registerModel.status == 200) {
          print("Success");
          yield state.copyWith(registerSubmit: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(registerSubmit: SubmissionFailure(e));
      }
    }
  }
}
