import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridViewLoading extends StatelessWidget {
  final int length;
  final Axis direction;
  const GridViewLoading({
    super.key,
    this.length = 8,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 12.0),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .9,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: length,
      itemBuilder: (_, index) => _GridViewLoadingIndicator(),
    );
  }
}

class _GridViewLoadingIndicator extends StatelessWidget {
  const _GridViewLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: 130,
        padding: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(39),
            bottomLeft: Radius.circular(39),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [],
        ),
      ),
    );
  }
}
