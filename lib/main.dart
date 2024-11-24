import 'package:doc_qa_flutter_app/config/app_theme.dart';
import 'package:doc_qa_flutter_app/config/constants/app_strings.dart';
import 'package:doc_qa_flutter_app/config/services/api_service.dart';
import 'package:doc_qa_flutter_app/home/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:doc_qa_flutter_app/home/repos/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
        title: AppStrings.appTitle,
        theme: AppThemes.lightTheme,
        home: BlocProvider(
          create: (context) =>
              UploadDocBloc(repo: HomeRepoImpl(apiService: ApiService())),
          child: const HomeScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
