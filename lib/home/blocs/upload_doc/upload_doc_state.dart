part of 'upload_doc_bloc.dart';

sealed class UploadDocState {}

final class UploadDocInitial extends UploadDocState {}

final class UploadDocInProgress extends UploadDocState {}

final class UploadDocSuccess extends UploadDocState {
  final DocumentUploadResponse response;

  UploadDocSuccess({required this.response});
}

final class UploadDocFailure extends UploadDocState {
  final String errorMessage;

  UploadDocFailure({required this.errorMessage});
}
