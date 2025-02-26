import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_icons.dart';

class PromotionsWidget extends StatelessWidget {
  const PromotionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: context.sizeOfWidth * 0.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(.0)),
        ),
        children:
            [
              AppIcons.banner1,
              AppIcons.banner2,
            ].map((e) => _BannerWidget(path: e)).toList(),
      ),
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget({required this.path});

  final String path;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: Image.asset(path, height: 150, width: 304, fit: BoxFit.fitHeight),
    );
  }
}
