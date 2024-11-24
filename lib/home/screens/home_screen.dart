import 'package:doc_qa_flutter_app/config/constants/app_colors.dart';
import 'package:doc_qa_flutter_app/config/constants/app_strings.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _promptTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _promptTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppStrings.appTitle,
            onMenuTap: () {},
          ),
          const Spacer(),
          _emptyChatUploadDocPlaceholder(),
          const Spacer(),
          _promptInputFieldWithUploadDoc(),
          const SizedBox(height: 16),
        ],
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
          onTap: () {},
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

  Widget _promptInputFieldWithUploadDoc() {
    return SidePadding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInkWell(
            onTap: () {},
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
