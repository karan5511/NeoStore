import 'package:flutter/animation.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/model/Fetch_Account_Model.dart';

class AccState {
  AccountDetails details;
  final FormSubmissionState editSubmit;

  AccState({this.details, this.editSubmit});

  AccState copyWith({
    AccountDetails details,
    FormSubmissionState editSubmit,
  }) {
    return AccState(
        details: details ?? this.details,
        editSubmit: editSubmit ?? this.editSubmit);
  }
}
