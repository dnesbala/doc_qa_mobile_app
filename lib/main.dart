import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'package:doc_qa_flutter_app/config/constants/app_colors.dart';
import 'package:doc_qa_flutter_app/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Doc QA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
          splashColor: Colors.pinkAccent.shade100,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
