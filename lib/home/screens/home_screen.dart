import 'dart:io';

import 'package:doc_qa_flutter_app/common/utils/toast_utils.dart';
import 'package:doc_qa_flutter_app/config/constants/app_colors.dart';
import 'package:doc_qa_flutter_app/config/constants/app_strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lottie/lottie.dart';

import 'package:doc_qa_flutter_app/common/widgets/custom_app_bar.dart';
import 'package:doc_qa_flutter_app/common/widgets/custom_ink_well.dart';
import 'package:doc_qa_flutter_app/common/widgets/side_padding.dart';
import 'package:doc_qa_flutter_app/config/constants/asset_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _promptTextController;
  int _currentInputLineCount = 1;
  String? selectedFilePath;

  late final ScrollController _scrollController;
  bool _showScrollToBottomButton = false;

  DateTime? _backPressDateTime;

  @override
  void initState() {
    _promptTextController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (selectedFilePath == null) return;
      final isAtBottom = _scrollController.position.atEdge &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent;

      setState(() {
        _showScrollToBottomButton = !isAtBottom;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _promptTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _tapAgainToExitApp();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(
                  title: AppStrings.appTitle,
                  onMenuTap: () {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selectedFilePath == null) ...{
                          Center(
                            heightFactor: 2,
                            child: _emptyChatUploadDocPlaceholder(),
                          ),
                        } else
                          _fileUploadedInitialWidget(),
                      ],
                    ),
                  ),
                ),
                _promptInputFieldWithUploadDoc(),
                const SizedBox(height: 16),
              ],
            ),
            if (_showScrollToBottomButton)
              Positioned(
                bottom: _currentInputLineCount == 1
                    ? 80
                    : _currentInputLineCount * 32,
                right: 16,
                child: FloatingActionButton(
                  onPressed: _scrollToBottom,
                  mini: true,
                  tooltip: "Scroll to bottom",
                  backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                  child: const Icon(Icons.arrow_downward_outlined,
                      color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _emptyChatUploadDocPlaceholder() {
    return Column(
      children: [
        Text(
          "Upload Document",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        GestureDetector(
          onTap: () {
            _uploadFile();
          },
          child: Lottie.asset(
            AssetSource.uploadDocLottie,
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          "to get started",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _fileUploadedInitialWidget() {
    return SidePadding(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _userQuestionBox(prompt: "Uploaded Doc:", pdfView: true),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text("Ask something about the document..",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.lightTextColor)),
              ),
            ),
          ),
          _userQuestionBox(prompt: "test question here?", pdfView: false),
          _docQaAnswerBox(answer: "lkorem ipsum test sajfk"),
          _userQuestionBox(prompt: "test question here?", pdfView: false),
          _docQaAnswerBox(
              answer:
                  "lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk"),
          _docQaAnswerBox(
              answer:
                  "lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk"),
          _docQaAnswerBox(
              answer:
                  "lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk"),
          _docQaAnswerBox(
              answer:
                  "lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk lkorem ipsum test sajfk"),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _promptInputFieldWithUploadDoc() {
    return SidePadding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInkWell(
            onTap: () {
              _uploadFile();
            },
            tooltipMessage: "Upload Document",
            child: const Icon(Icons.upload_file_outlined),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _promptTextController,
              onChanged: (String val) {
                _updateLineCount(val);
              },
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: _currentInputLineCount,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                hintText: "Ask ${AppStrings.appTitle}",
                hintStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _promptTextController.text.isNotEmpty
                ? Row(
                    children: [
                      const SizedBox(width: 16),
                      CustomInkWell(
                        onTap: () {},
                        tooltipMessage: "Submit Prompt",
                        child: const Icon(Icons.send_outlined),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _userQuestionBox({
    required String prompt,
    bool pdfView = false,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(prompt,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor.withOpacity(0.8),
                        )),
              ),
              if (pdfView) ...{
                const SizedBox(height: 4),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: PDFView(
                    filePath: selectedFilePath,
                    swipeHorizontal: true,
                    autoSpacing: true,
                    onError: (error) {
                      showErrorToast(description: error);
                    },
                  ),
                ),
                const SizedBox(height: 8),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _docQaAnswerBox({required String answer}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.lightTextColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  void _tapAgainToExitApp() {
    if (_backPressDateTime == null ||
        DateTime.now().difference(_backPressDateTime!).inSeconds > 3) {
      _backPressDateTime = DateTime.now();
      showSuccessToast(
        title: "Tap again to exit..",
        autoCloseDuration: const Duration(seconds: 2),
      );
    } else {
      SystemNavigator.pop();
    }
  }

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        selectedFilePath = file.path;
      });
    } else {
      showErrorToast(description: "Please select a document");
    }
  }

  void _updateLineCount(String text) {
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(fontSize: 16),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 7,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: MediaQuery.of(context).size.width - 150,
    );

    final lineCount = textPainter.computeLineMetrics().length + 1;

    setState(() {
      _currentInputLineCount = lineCount > 7 ? 7 : lineCount;
    });
  }
}
