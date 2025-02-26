import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';
import 'package:pharma_connect/core/widget_ext.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
    this.onPop,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final VoidCallback? onPop;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontSize: 16,
      ),
      title: Text(title),
      leading: InkWell(
        onTap: onPop ?? context.close,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.keyboard_backspace).showIf(automaticallyImplyLeading),
        ),
      ),
      leadingWidth: automaticallyImplyLeading ? 24 : 0,
      elevation: 6,
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Stack(
            children: [
              Icon(Icons.notifications, color: AppColors.white),
              Positioned(
                right: 3,
                top: 2,
                child: CircleAvatar(
                  minRadius: 3,
                  maxRadius: 3,
                  backgroundColor: Color(0xFFE73152),
                ),
              ),
            ],
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[AppColors.oceanBreeze, AppColors.darkTeal],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
