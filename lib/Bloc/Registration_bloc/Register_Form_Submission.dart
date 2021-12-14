
abstract class FormSubmissionState{
  const FormSubmissionState();
}

class InitialState extends FormSubmissionState{
  const InitialState();
}

class FormSubmittingState extends FormSubmissionState{
  const FormSubmittingState();
}

class SubmissionSuccess extends FormSubmittingState{}

class SubmissionFailure extends FormSubmittingState{

  final Exception exception;

  SubmissionFailure(this.exception);

}