import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';
import 'package:pharma_connect/core/widget_ext.dart';
import 'package:pharma_connect/core/widgets/empty_data_widget.dart';
import 'package:pharma_connect/core/widgets/section_widget.dart';
import 'package:pharma_connect/core/widgets/simple_app_bar.dart';
import 'package:pharma_connect/features/cart/model/cart.dart';
import 'package:pharma_connect/features/cart/ui/bloc/cubit/add_to_cart.dart';
import 'package:pharma_connect/features/home_page/presentation/home_page.dart';
import 'package:pharma_connect/features/home_page/presentation/product_details_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Cart',
        onPop: () => globalPageController.jumpToPage(0),
      ),
      body: BlocBuilder<AddToCartCubit, List<Cart>>(
        builder: (_, state) {
          if (state.isEmpty) {
            return EmptyDataWidget(message: 'Cart is Empty');
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 4.0),
            padding: EdgeInsets.all(12.0),
            itemCount: state.length,
            itemBuilder: (_, index) {
              final cartItem = state.elementAt(index);
              return Dismissible(
                key: Key(cartItem.index.toString()),
                onDismissed:
                    (direction) =>
                        context.bloc<AddToCartCubit>().remove(cartItem.index),
                child: SectionWidget(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  child: ListTile(
                    onTap:
                        () => context.goToPage(
                          ProductDetailsView.fetchDetails(context, cartItem.drug),
                        ),
                    tileColor: Colors.white,
                    contentPadding: EdgeInsets.all(0),
                    selectedTileColor: Colors.white,
                    title: Text(cartItem.drug.name),
                    titleTextStyle: context.textTheme.labelMedium,
                    leading: Image.network(cartItem.drug.image),
                    trailing: Badge.count(
                      count: cartItem.units,
                      backgroundColor: AppColors.darkTeal,
                      child: Icon(Icons.shopping_cart),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _OrderNowBtn(),
    );
  }
}

class _OrderNowBtn extends StatelessWidget {
  const _OrderNowBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartCubit, List<Cart>>(
      builder: (_, state) {
        return FloatingActionButton.extended(
          backgroundColor: AppColors.darkTeal,
          extendedTextStyle: context.textTheme.titleMedium,
          onPressed: () {},
          label: Text('Order Now', style: TextStyle(color: AppColors.white)),
          icon: Icon(Icons.shopping_cart, color: AppColors.white),
        ).showIf(state.isNotEmpty);
      },
    );
  }
}
