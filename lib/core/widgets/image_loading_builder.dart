import 'package:flutter/material.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

Widget imageLoadingBuilder(
  BuildContext context,
  Widget child,
  ImageChunkEvent? loadingProgress, {
  double size = 24.0,
  Color color = AppColors.darkTeal,
}) {
  if (loadingProgress == null) return child;

  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    ),
  );
}