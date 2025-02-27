import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/core.dart';
import 'package:pharma_connect/features/my_orders/presentation/bloc/create_order/create_order_cubit.dart';

class ProductBottomBtns extends StatefulWidget {
  const ProductBottomBtns({
    super.key,
    required this.maxUnits,
    required this.onProceed,
  });

  final int maxUnits;
  final void Function(int count) onProceed;
  @override
  State<ProductBottomBtns> createState() => _ProductBottomBtnsState();
}

class _ProductBottomBtnsState extends State<ProductBottomBtns> {
  int count = 1;

  bool get canAdd => count < widget.maxUnits;
  bool get canReduce => count > 1;

  void _increment() {
    if(canAdd) {
      setState(() => count++);
    } else {
      context.showSnackbar('You have reached maximum limit!', AppSnackBarType.error);
    }
  }

  void _decrement() => setState(() => count--);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: AppColors.white,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.slateGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                IconButton(
                  onPressed: canReduce ? _decrement : null,
                  icon: Icon(
                    Icons.remove,
                    size: 14,
                    color: canReduce ? AppColors.black : AppColors.lavenderGrey,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  count.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: _increment,
                  icon: Icon(
                    Icons.add,
                    size: 14,
                    color: AppColors.lavenderGrey,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ).expanded(),
          _PlaceOrderBtn(onTap: () => widget.onProceed(count)).expanded(),
        ],
      ),
    );
  }
}

class _PlaceOrderBtn extends StatelessWidget {
  const _PlaceOrderBtn({this.onTap});

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
      builder: (_, state) {
        final isloading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        return OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.deepteal,
            side: BorderSide(
              color: isloading ? AppColors.divider : AppColors.deepteal,
            ),
            textStyle: context.textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
            disabledBackgroundColor: AppColors.divider,
            foregroundColor: Colors.white,
            shape: ContinuousRectangleBorder(),
          ),
          onPressed: isloading ? null : onTap,
          iconAlignment: IconAlignment.end,
          icon: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.white,
          ).showIf(!isloading),
          label:
              isloading
                  ? CupertinoActivityIndicator(color: AppColors.darkTeal)
                  : Text('Place Order'),
        );
      },
    );
  }
}
