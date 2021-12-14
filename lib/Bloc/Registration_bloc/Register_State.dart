import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

class RegisterState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final dynamic phoneNumber;
  final FormSubmissionState registerSubmit;

  RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.gender = '',
    this.phoneNumber = '',
    this.registerSubmit = const InitialState(),
  });

  RegisterState copyWith({
    String firstName,
    String lastName,
     String email,
     String password,
     String confirmPassword,
     String gender,
     dynamic phoneNo,
    FormSubmissionState registerSubmit,

  }){
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName ,
      email: email ?? this.email ,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      registerSubmit: registerSubmit ?? this.registerSubmit,

    );
  }
}
