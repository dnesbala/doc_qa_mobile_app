import 'package:bloc/bloc.dart';
import 'package:doc_qa_flutter_app/home/models/prompt_answer.dart';
import 'package:doc_qa_flutter_app/home/repos/home_repo.dart';

part 'submit_prompt_event.dart';
part 'submit_prompt_state.dart';

class SubmitPromptBloc extends Bloc<SubmitPromptEvent, SubmitPromptState> {
  final HomeRepo _repo;
  SubmitPromptBloc({required HomeRepo repo})
      : _repo = repo,
        super(SubmitPromptInitial()) {
    on<StartSubmitPrompt>((event, emit) async {
      try {
        emit(SubmitPromptInProgress());
        final response = await _repo.submitPrompt(
            documentId: event.docId, prompt: event.prompt);
        emit(SubmitPromptSuccess(answer: response));
      } catch (err) {
        emit(SubmitPromptFailure(errorMessage: err.toString()));
      }
    });
  }
}
