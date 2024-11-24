import 'package:doc_qa_flutter_app/config/constants/asset_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuTap;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 183, 110, 174),
            Color.fromARGB(255, 182, 77, 138)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(AssetSource.menuIcon, color: Colors.white),
          onPressed: onMenuTap,
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
