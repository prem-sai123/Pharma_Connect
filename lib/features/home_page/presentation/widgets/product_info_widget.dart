import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/widget_ext.dart';
import 'package:pharma_connect/core/widgets/section_widget.dart';
import 'package:pharma_connect/features/home_page/model/product_details.dart';

class ProductInfoWidget extends StatefulWidget {
  const ProductInfoWidget({super.key, required this.details});

  final ProductDetails details;

  @override
  State<ProductInfoWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> {
  bool _viewAll = false;

  void _toggleViewAll() {
    setState(() {
      _viewAll = !_viewAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      color: Color(0xFFFFFFFF),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18.0,
        children: [
          _InfoWidget(info: widget.details.info),
          _HeaderListWidget(title: 'Uses:', values: widget.details.uses),
          if (_viewAll) ...[
            _HeaderListWidget(
              title: 'Product Features And Specifications:',
              values: widget.details.featAndSpecs,
            ),
            _HeaderListWidget(
              title: 'Directions For Use:',
              values: widget.details.directions,
            ),
            _HeaderListWidget(
              title: 'Safety Information:',
              values: widget.details.safetyInfo,
            ),
          ],
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: _toggleViewAll,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _viewAll ? 'View Less' : 'View More',
                    // style: context.textTheme.labelMedium?.copyWith(
                    //   decoration: TextDecoration.underline,
                    //   color: Color(0xFF1890FF),
                    // ),
                    style: context.textTheme.labelMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(color: Color(0xFF1890FF), offset: Offset(0, -4)),
                      ],
                      decorationColor: Color(0xFF1890FF),
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                  Icon(
                    _viewAll
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color(0xFF1890FF),
                  ),
                ],
              ).paddingSymmetric(horizontal: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget({required this.info});

  final String info;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Text(
          'Product Information',
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(info, style: TextStyle(color: Color(0xFF5A5959))),
      ],
    );
  }
}

class _HeaderListWidget extends StatelessWidget {
  const _HeaderListWidget({required this.title, required this.values});
  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Text(
          title,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        ...values.map(
          (e) => Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '\u2022',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                WidgetSpan(child: SizedBox(width: 6.0)),
                TextSpan(text: e, style: TextStyle(color: Color(0xFF5A5959))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
