import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/gridlist_widget.dart';

class SampleDrugsList extends StatelessWidget {
  const SampleDrugsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sample Drugs',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          'List of drugs assigned to you',
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.slateGrey,
          ),
        ),
        GridListWidget(),
      ],
    );
  }
}
