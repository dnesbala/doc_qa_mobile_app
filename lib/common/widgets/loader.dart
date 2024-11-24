import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:doc_qa_flutter_app/config/constants/app_colors.dart';
import 'package:doc_qa_flutter_app/config/constants/asset_source.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AssetSource.dotLoaderLottie,
        delegates: LottieDelegates(
          values: [
            ValueDelegate.color(
              const ['**'],
              value: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
