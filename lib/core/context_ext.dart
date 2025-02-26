import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

enum AppSnackBarType { error, success, info }

extension BuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  double get sizeOfWidth => MediaQuery.sizeOf(this).width;

  Future<T?> goToPage<T>(Widget child) =>
      Navigator.of(this).push<T?>(MaterialPageRoute(builder: (ctx) => child));

  void close<T>([T? data]) => Navigator.of(this).pop(data);
  T bloc<T extends Cubit<Object>>() => BlocProvider.of<T>(this);

  void showSnackbar(
    String content, [
    AppSnackBarType type = AppSnackBarType.info,
  ]) {
    final borderColor = switch(type) {
      AppSnackBarType.error => Colors.red,
      AppSnackBarType.success => AppColors.darkTeal,
      AppSnackBarType.info => AppColors.divider,
    };
    final statusWidget = switch(type) {
      AppSnackBarType.info  || AppSnackBarType.error => Icon(Icons.info_outline   , size: 18),
      AppSnackBarType.success => Icon(Icons.check, size: 18),
    };
    // ScaffoldMessenger.of(this).showSnackBar(
    //   SnackBar(
    //     behavior: SnackBarBehavior.floating,
    //     elevation: 0,
    //     content: Text(
    //       content,
    //       style: textTheme.labelLarge?.copyWith(color: AppColors.white),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );
    FToast()
        .init(this)
        .showToast(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(4.0),
              color: Color(0xFFFFFFFF),
            ),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.0,
              children: [
                statusWidget,
                Text(
                  content,
                  style: textTheme.labelLarge?.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ),
          gravity: ToastGravity.TOP,
          toastDuration: Duration(seconds: 2),
        );
  }
}
