import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/widget_ext.dart';
import 'package:pharma_connect/core/widgets/simple_app_bar.dart';
import 'package:pharma_connect/features/cart/model/cart.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/features/home_page/presentation/bloc/product_details/product_details_cubit.dart';
import 'package:pharma_connect/features/home_page/presentation/bloc/sample_drugs/sample_drugs_cubit.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/gridlist_widget.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/product_bottom_btns.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/product_info_widget.dart';
import 'package:pharma_connect/features/my_orders/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:pharma_connect/features/my_orders/presentation/bloc/orders/orders_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.drug});

  final SampleDrug drug;
  static Widget fetchDetails(BuildContext ctxt, SampleDrug drug) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductDetailsCubit.get()..fetchDetails(drug),
        ),
        BlocProvider(create: (_) => CreateOrderCubit.get()),
        BlocProvider(create: (_) => ctxt.bloc<SampleDrugsCubit>()),
      ],
      child: ProductDetailsView(drug: drug),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: drug.name),
      body: BlocListener<CreateOrderCubit, CreateOrderState>(
        listener: (_, state) {
          state.maybeWhen(
            orElse: () {},
            success: (data) {
              context.showSnackbar(
                'Order Placed Successfully..!',
                AppSnackBarType.success,
              );
              context.bloc<OrdersCubit>().fetchOrders();
            },
          );
        },
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (_, state) {
            return state.maybeWhen(
              orElse: () => Center(child: CircularProgressIndicator()),
              success:
                  (details) => Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.0,
                          children: [
                            Image.network(details.image, height: 224).center(),
                            _titleWidget(context),
                            _prodMode(context),
                            _unitsWidget(),
                            ProductInfoWidget(details: details),
                            GridListWidget(id: details.id),
                          ],
                        ),
                      ).expanded(),
                      ProductBottomBtns(
                        maxUnits: details.maxUnits,
                        onProceed: (count) {
                          final cart = Cart(
                            index: 0,
                            drug: drug,
                            units: count,
                            dateTime: DateTime.now(),
                          );
                          context.bloc<CreateOrderCubit>().createOrder(cart);
                        },
                      ),
                    ],
                  ),
            );
          },
        ),
      ),
    );
  }

  Widget _prodMode(BuildContext context) => Row(
    spacing: 8.0,
    children: [
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'FREE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            WidgetSpan(child: SizedBox(width: 4.0)),
            TextSpan(
              text: 'Sample',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        style: context.textTheme.labelMedium?.copyWith(fontSize: 14),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Color(0xFFCDEEF1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'TRIAL',
          style: context.textTheme.labelSmall?.copyWith(
            color: Color(0xFF10676E),
          ),
        ),
      ),
    ],
  ).paddingSymmetric(horizontal: 12.0, vertical: 2.0);

  Widget _titleWidget(BuildContext context) => Text(
    drug.name,
    style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
  ).paddingSymmetric(horizontal: 12.0);

  Widget _unitsWidget() => Container(
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(color: Color(0xFFC5E2FD)),
    alignment: Alignment.center,
    child: Text(
      'Maximum of ${drug.units} units can be added in the cart.',
      style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF656C73)),
    ),
  );
}
