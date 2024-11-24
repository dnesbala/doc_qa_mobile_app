import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeSharedPref {
  static Future<void> saveDocument(Map<String, dynamic> document) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing documents
    final String? documentsString = prefs.getString("documents");
    List<Map<String, dynamic>> documents = [];

    if (documentsString != null) {
      documents = List<Map<String, dynamic>>.from(jsonDecode(documentsString));
    }

    // Find the index of the existing document (if present)
    final int existingIndex =
        documents.indexWhere((doc) => doc['id'] == document['id']);

    if (existingIndex != -1) {
      documents[existingIndex] = document;
    } else {
      documents.add(document);
    }

    prefs.setString("documents", jsonEncode(documents));
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? documentsString = prefs.getString("documents");

    if (documentsString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(documentsString));
    }

    return [];
  }
}
