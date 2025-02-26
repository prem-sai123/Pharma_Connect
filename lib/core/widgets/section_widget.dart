import 'package:flutter/material.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

class SectionWidget extends StatelessWidget {
  SectionWidget({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.only(bottom: 8.0),
    this.padding = const EdgeInsets.all(8.0),
    BorderRadiusGeometry? borderRadius,
    this.color = AppColors.white,
  }) {
    this.borderRadius = borderRadius ?? BorderRadius.circular(.0);
  }

  final Widget child;
  final Color color;
  late final BorderRadiusGeometry? borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: Border.all(color: color),
      ),
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
