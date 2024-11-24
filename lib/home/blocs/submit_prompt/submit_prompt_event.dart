part of 'submit_prompt_bloc.dart';

sealed class SubmitPromptEvent {}

class StartSubmitPrompt extends SubmitPromptEvent {
  final int docId;
  final String prompt;

  StartSubmitPrompt({
    required this.docId,
    required this.prompt,
  });
}
