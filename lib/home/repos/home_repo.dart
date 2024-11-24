import 'package:doc_qa_flutter_app/config/constants/app_strings.dart';
import 'package:doc_qa_flutter_app/config/services/api_service.dart';
import 'package:doc_qa_flutter_app/home/models/document_upload_response.dart';
import 'package:doc_qa_flutter_app/home/models/prompt_answer.dart';

abstract class HomeRepo {
  Future<DocumentUploadResponse> uploadDocument({required String documentPath});
  Future<PromptAnswer> submitPrompt(
      {required int documentId, required String prompt});
}

class HomeRepoImpl implements HomeRepo {
  final ApiService _apiService;

  HomeRepoImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<DocumentUploadResponse> uploadDocument(
      {required String documentPath}) async {
    try {
      final response = await _apiService.uploadFile(
        AppStrings.uploadDocumentApi,
        filePath: documentPath,
        data: {},
        onProgress: (double progress) {},
      );
      return DocumentUploadResponse.fromJson(response.data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<PromptAnswer> submitPrompt(
      {required int documentId, required String prompt}) async {
    try {
      final response = await _apiService.post(
        AppStrings.submitPromptApi,
        {
          "document_id": documentId,
          "question": prompt,
        },
      );
      return PromptAnswer.fromJson(response.data);
    } catch (err) {
      rethrow;
    }
  }
}
