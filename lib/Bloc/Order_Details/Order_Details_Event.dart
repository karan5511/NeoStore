import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class OrderDetailsEvent {}

class OnOrderDetailsClicked extends OrderDetailsEvent {
  FormSubmissionState orderDetail;
  String accessToken;
  String id;

  OnOrderDetailsClicked({this.accessToken, this.id});
}
