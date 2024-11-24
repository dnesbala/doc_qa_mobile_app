part of 'submit_prompt_bloc.dart';

sealed class SubmitPromptState {}

final class SubmitPromptInitial extends SubmitPromptState {}

final class SubmitPromptInProgress extends SubmitPromptState {}

final class SubmitPromptSuccess extends SubmitPromptState {
  final PromptAnswer answer;

  SubmitPromptSuccess({required this.answer});
}

final class SubmitPromptFailure extends SubmitPromptState {
  final String errorMessage;

  SubmitPromptFailure({required this.errorMessage});
}
