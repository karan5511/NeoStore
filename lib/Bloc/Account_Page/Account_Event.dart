import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class AccEvent {}

class OnEditButtonClicked extends AccEvent {
  FormSubmissionState editSubmit;
  String token;

  OnEditButtonClicked({
    this.token,
  });
}
