import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = "https://api-endpoint.com";

  ApiService() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      // return response;
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> uploadFile(
    String endpoint, {
    required String filePath,
    required Map<String, dynamic> data,
    required ValueChanged<double> onProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last),
        ...data,
      });

      final response = await dio.post(
        endpoint,
        data: formData,
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          onProgress(progress);
        },
      );

      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  _handleResponse(Response response) {
    if (response.data != null) {
      final statusCode = response.data["status-code"];

      // success status code is 1
      if (statusCode == 1) {
        return response;
      } else {
        _handleError(response.data["status-message"] ?? "Something Went Wrong");
      }
    } else {
      _handleError("Something Went Wrong");
    }
  }

  Future<Response> _handleError(dynamic error) async {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception("Connection Timeout");
        case DioExceptionType.sendTimeout:
          throw Exception("Send Timeout");
        case DioExceptionType.receiveTimeout:
          throw Exception("Receive Timeout");
        case DioExceptionType.badResponse:
          throw Exception("Invalid response: ${error.response?.statusCode}");
        case DioExceptionType.cancel:
          throw Exception("Request Cancelled");
        case DioExceptionType.badCertificate:
          throw Exception("Bad Certificate");
        case DioExceptionType.connectionError:
          throw Exception("Connection Error");
        case DioExceptionType.unknown:
          throw Exception("Something Went Wrong");
      }
    } else {
      throw Exception(error);
    }
  }
}