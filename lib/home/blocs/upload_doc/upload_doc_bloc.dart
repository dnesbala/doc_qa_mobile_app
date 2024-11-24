import 'package:bloc/bloc.dart';
import 'package:doc_qa_flutter_app/home/models/document_upload_response.dart';
import 'package:doc_qa_flutter_app/home/repos/home_repo.dart';

part 'upload_doc_event.dart';
part 'upload_doc_state.dart';

class UploadDocBloc extends Bloc<UploadDocEvent, UploadDocState> {
  final HomeRepo _homeRepo;
  UploadDocBloc({required HomeRepo repo})
      : _homeRepo = repo,
        super(UploadDocInitial()) {
    on<UploadDocEvent>((event, emit) async {
      if (event is StartUploadDocument) {
        try {
          emit(UploadDocInProgress());
          final response =
              await _homeRepo.uploadDocument(documentPath: event.docPath);
          emit(UploadDocSuccess(response: response));
        } catch (err) {
          emit(UploadDocFailure(errorMessage: err.toString()));
        }
      }
    });
  }
}
