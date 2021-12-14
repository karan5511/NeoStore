import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';

abstract class OrderListEvent {}

class OnMyOrdersClicked extends OrderListEvent {
  FormSubmissionState orderList;
  String accessToken;

  OnMyOrdersClicked({
    this.accessToken,
  });
}
