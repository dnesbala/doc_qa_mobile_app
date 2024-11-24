part of 'upload_doc_bloc.dart';

sealed class UploadDocEvent {}

class StartUploadDocument extends UploadDocEvent {
  final String docPath;

  StartUploadDocument({required this.docPath});
}
