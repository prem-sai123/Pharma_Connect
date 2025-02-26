import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key, this.message = 'No Data Found.!'});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message, style: context.textTheme.labelMedium),
      ),
    );
  }
}
