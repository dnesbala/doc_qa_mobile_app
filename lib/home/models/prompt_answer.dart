import 'dart:convert';

PromptAnswer promptAnswerFromJson(String str) =>
    PromptAnswer.fromJson(json.decode(str));

String promptAnswerToJson(PromptAnswer data) => json.encode(data.toJson());

class PromptAnswer {
  final int? status;
  final String? message;
  final Details? details;

  PromptAnswer({
    this.status,
    this.message,
    this.details,
  });

  factory PromptAnswer.fromJson(Map<String, dynamic> json) => PromptAnswer(
        status: json["status"],
        message: json["message"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "details": details?.toJson(),
      };
}

class Details {
  final String? question;
  final String? answer;
  final String? documentName;
  final double? confidenceScore;

  Details({
    this.question,
    this.answer,
    this.documentName,
    this.confidenceScore,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        question: json["question"],
        answer: json["answer"],
        documentName: json["document_name"],
        confidenceScore: json["confidence_score"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "document_name": documentName,
        "confidence_score": confidenceScore,
      };
}
