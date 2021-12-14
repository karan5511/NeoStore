import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Account_Page/Account_Event.dart';
import 'package:neo_store/Bloc/Account_Page/Account_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Repository/Fetch_Account_repo.dart';
import 'package:neo_store/model/Fetch_Account_Model.dart';

class AccBloc extends Bloc<AccEvent, AccState> {
  AccDetailsRepo accAuthRepo;

  AccBloc({this.accAuthRepo}) : super(AccState());

  @override
  Stream<AccState> mapEventToState(AccEvent event) async* {
    if (event is OnEditButtonClicked) {
      yield state.copyWith(editSubmit: event.editSubmit);

      try {
        AccountDetails accdetails =
            await accAuthRepo.getAccountDetails(accessToken: event.token);
        if (accdetails.status == 200) {
          print("Success");
          yield state.copyWith(editSubmit: SubmissionSuccess());
          yield state.copyWith(details: accdetails);
        }
      } on Exception catch (e) {
        print("Failed");
        yield state.copyWith(editSubmit: SubmissionFailure(e));
      }
    }
  }
}
