import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);
  Widget center() => Center(child: this);
  Widget marginAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget showIf(bool value) => value ? this : const SizedBox.shrink();
}
