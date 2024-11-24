import 'package:doc_qa_flutter_app/config/services/api_service.dart';
import 'package:doc_qa_flutter_app/home/blocs/submit_prompt/submit_prompt_bloc.dart';
import 'package:doc_qa_flutter_app/home/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:doc_qa_flutter_app/home/repos/home_repo.dart';
import 'package:doc_qa_flutter_app/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> documents;

  const HistoryDrawer({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * .8,
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB02782),
            ),
            child: Center(
              child: Text(
                'Document Q&A History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (documents.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No history available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => UploadDocBloc(
                                        repo: HomeRepoImpl(
                                            apiService: ApiService())),
                                  ),
                                  BlocProvider(
                                    create: (context) => SubmitPromptBloc(
                                        repo: HomeRepoImpl(
                                            apiService: ApiService())),
                                  ),
                                ],
                                child: HomeScreen(document: document),
                              )));
                    },
                    title: Text(
                      "Doc ID: ${document["id"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(document["path"].toString().split("/").last),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
