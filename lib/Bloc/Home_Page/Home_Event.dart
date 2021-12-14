import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class HomeEvent {}

class OnHomeButtonClicked extends HomeEvent {
  FormSubmissionState homepageSubmit;
  String id;

  OnHomeButtonClicked({
    this.id,
  });
}
