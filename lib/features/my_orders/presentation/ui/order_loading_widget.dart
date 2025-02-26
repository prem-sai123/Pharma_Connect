import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:shimmer/shimmer.dart';

class OrderLoadingWidget extends StatelessWidget {
  const OrderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 8,
      padding: EdgeInsets.all(12.0),
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder:
          (_, _) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: context.sizeOfWidth,
              height: 140,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              ),
            ),
          ),
    );
  }
}
