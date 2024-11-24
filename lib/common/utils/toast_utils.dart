import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastMessage {
  final String? title;
  final String? description;
  final ToastificationType type;
  final Color primaryColor;
  final Duration? autoCloseDuration;

  ToastMessage({
    this.title,
    this.description,
    required this.type,
    required this.primaryColor,
    this.autoCloseDuration,
  });

  void show() {
    toastification.show(
      title: title == null ? null : Text(title!),
      description: description == null ? null : Text(description!),
      type: type,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
      primaryColor: primaryColor,
      showProgressBar: false,
      dragToClose: true,
      closeOnClick: true,
    );
  }
}

void showSuccessToast({
  String? title,
  String? description,
  Duration? autoCloseDuration,
}) {
  final toast = ToastMessage(
    title: title,
    description: description,
    type: ToastificationType.success,
    primaryColor: Colors.teal,
    autoCloseDuration: autoCloseDuration,
  );
  toast.show();
}

void showErrorToast({String? title, String? description}) {
  final toast = ToastMessage(
    title: title,
    description: description,
    type: ToastificationType.error,
    primaryColor: Colors.pink,
  );
  toast.show();
}
