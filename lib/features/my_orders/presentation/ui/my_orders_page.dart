import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharma_connect/core/core.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/features/home_page/presentation/home_page.dart';
import 'package:pharma_connect/features/home_page/presentation/product_details_view.dart';
import 'package:pharma_connect/features/my_orders/model/my_order.dart';
import 'package:pharma_connect/features/my_orders/presentation/bloc/orders/orders_cubit.dart';
import 'package:pharma_connect/features/my_orders/presentation/ui/order_loading_widget.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'My Orders',
        onPop: () => globalPageController.jumpToPage(0),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (_, state) {
          return state.maybeWhen(
            orElse: () => OrderLoadingWidget(),
            success: (orders) {
              final data = [...orders];
              data.sort((a, b) => b.orderId.compareTo(a.orderId));
              if (data.isEmpty) {
                return const EmptyDataWidget(message: 'No Orders Found..!');
              }
              return ListView.builder(
                itemCount: data.length,
                padding: EdgeInsets.all(12.0),
                itemBuilder: (_, index) {
                  final order = data.elementAt(index);
                  return _OrderWidget(
                    order: order,
                    onTap: () {
                      final drug = SampleDrug(
                        id: order.productId,
                        name: order.name,
                        units: 12,
                        image: order.image,
                      );
                      context.goToPage(ProductDetailsView.fetchDetails(context, drug));
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _OrderWidget extends StatelessWidget {
  const _OrderWidget({required this.order, this.onTap});

  final MyOrder order;
  final VoidCallback? onTap;

  String get formattedDate {
    final strDate = order.createdOn;
    final format = DateFormat('dd MMM yyyy HH:mm:ss');
    final dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').parse(strDate);
    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      padding: EdgeInsets.all(8.0),
      borderRadius: BorderRadius.circular(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orderId(context),
          Text(formattedDate, style: context.textTheme.labelSmall),
          Divider(color: AppColors.divider, height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [_imageWidget(), _orderInfo().expanded()],
          ),
        ],
      ),
    );
  }

  Row _orderId(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Order: #${order.orderId}', style: context.textTheme.titleMedium),
        IconButton(
          onPressed: onTap,
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.arrow_forward, color: Color(0xFF1890FF)),
        ),
      ],
    );
  }

  Widget _imageWidget() => Image.network(
    order.image,
    height: 64,
    width: 64,
    loadingBuilder: imageLoadingBuilder,
  );

  Column _orderInfo() {
    final statusText = order.unit > 1 ? 'Items' : 'Item';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [Text(order.status), Text('${order.unit} $statusText')],
    );
  }
}
