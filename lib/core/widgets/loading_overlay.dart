import 'package:flutter/material.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

class LoadingOverlay {
  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
  BuildContext _context;

  void hide() => _context.close();

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (ctx) => _FullScreenLoader(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: PopScope(
        canPop: false,
        child: Container(
          height: 120,
          width: context.sizeOfWidth,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Column(
              spacing: 10.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.deepteal),
                Text('Please Wait...!'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
