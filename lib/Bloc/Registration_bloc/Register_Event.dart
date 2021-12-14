import 'Register_Form_Submission.dart';

abstract class RegisterEvent{
}

class RegisterFirstNameChanged extends RegisterEvent{
  final String firstName;
  RegisterFirstNameChanged({this.firstName});
}

class RegisterLastNameChanged extends RegisterEvent{
  final String lastName;
  RegisterLastNameChanged({this.lastName});
}

class RegisterEmailChanged extends RegisterEvent{
  final String email;
  RegisterEmailChanged({this.email});
}

class RegisterPasswordChanged extends RegisterEvent{
  final String password;
  RegisterPasswordChanged({this.password});
}

class RegisterConfirmPasswordChanged extends RegisterEvent{
  final String confirmPassword;
  RegisterConfirmPasswordChanged({this.confirmPassword});
}

class RegisterGenderChanged extends RegisterEvent{
  final String gender;
  RegisterGenderChanged({this.gender});
}

class RegisterPhoneNumberChanged extends RegisterEvent{
  final String phoneNo;
  RegisterPhoneNumberChanged({this.phoneNo});
}

class RegisterTermsAndConditionsChanged extends RegisterEvent{
  final String termsAndConditions;
  RegisterTermsAndConditionsChanged({this.termsAndConditions});
}

class RegisterSubmitted extends RegisterEvent{
  FormSubmissionState registersubmit;
String firstName;
String lastName;
String email;
String password;
String confirmPassword;
String gender;
String phoneNumber;


  RegisterSubmitted ({
   this. firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phoneNumber,

});


}


