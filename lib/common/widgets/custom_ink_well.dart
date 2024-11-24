import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double? borderRadius;
  final String? tooltipMessage;

  const CustomInkWell({
    required this.child,
    required this.onTap,
    this.borderRadius,
    this.tooltipMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        child: child,
      ),
    );
  }
}
