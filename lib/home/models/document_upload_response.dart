import 'dart:convert';

DocumentUploadResponse documentUploadResponseFromJson(String str) =>
    DocumentUploadResponse.fromJson(json.decode(str));

String documentUploadResponseToJson(DocumentUploadResponse data) =>
    json.encode(data.toJson());

class DocumentUploadResponse {
  final int? status;
  final String? message;
  final DocumentDetails? details;

  DocumentUploadResponse({
    this.status,
    this.message,
    this.details,
  });

  factory DocumentUploadResponse.fromJson(Map<String, dynamic> json) =>
      DocumentUploadResponse(
        status: json["status"],
        message: json["message"],
        details: json["details"] == null
            ? null
            : DocumentDetails.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "details": details?.toJson(),
      };
}

class DocumentDetails {
  final int? id;
  final String? file;
  final DateTime? uploadedAt;
  final String? name;
  final String? content;

  DocumentDetails({
    this.id,
    this.file,
    this.uploadedAt,
    this.name,
    this.content,
  });

  factory DocumentDetails.fromJson(Map<String, dynamic> json) =>
      DocumentDetails(
        id: json["id"],
        file: json["file"],
        uploadedAt: json["uploaded_at"] == null
            ? null
            : DateTime.parse(json["uploaded_at"]),
        name: json["name"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "uploaded_at": uploadedAt?.toIso8601String(),
        "name": name,
        "content": content,
      };
}
