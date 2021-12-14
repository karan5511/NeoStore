import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Edit_Account/Edit_Account_Event.dart';
import 'package:neo_store/Bloc/Edit_Account/Edit_Account_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/Edit_Account_repo.dart';
import 'package:neo_store/model/Register_model.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
EditAccRepo editAccRepo;
  EditAccountBloc({this.editAccRepo}) : super(EditAccountState());
  @override
  Stream<EditAccountState> mapStateToEvent(EditAccountEvent event) async* {
    if (event is OnFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is OnLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is OnEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is OnDobChanged) {
      yield state.copyWith(dob: event.dob);
    } else if (event is OnPhoneNoChanged) {
      yield state.copyWith(phoneNo: event.phoneNo);
    } else if (event is OnProfilePicChanged) {
      yield state.copyWith(profilePic: event.profilePic);
    } else if (event is OnSubmitClick) {
      yield state.copyWith(
          editSubmit: FormSubmittingState(),
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          dob: event.dob,
          phoneNo: event.phoneNo,
          profilePic: event.profilePic
      );
      print('edit account details');
      try
      {

        await editAccRepo.addData(event.accessToken ,event.dob, event.profilePic, event.email, event.phoneNo, event.firstName, event.lastName);


        print("Success");
        yield state.copyWith(editSubmit: SubmissionSuccess());

    } on Exception catch (e) {
    print(e);
    print(e);
    yield state.copyWith(editSubmit: SubmissionFailure(e));
    }
    }
    }
  }

