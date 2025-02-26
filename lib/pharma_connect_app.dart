import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharma_connect/features/cart/ui/bloc/cubit/add_to_cart.dart';
import 'package:pharma_connect/features/home_page/presentation/bloc/sample_drugs/sample_drugs_cubit.dart';
import 'package:pharma_connect/features/home_page/presentation/home_page.dart';
import 'package:pharma_connect/features/my_orders/presentation/bloc/orders/orders_cubit.dart';
import 'package:pharma_connect/features/profile/presentation/bloc/profile_details/profile_details_cubit.dart';

class PharmaConnectApp extends StatelessWidget {
  const PharmaConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SampleDrugsCubit.get()..fetchSampleDrugs()),
        BlocProvider(create: (_) => AddToCartCubit()),
        BlocProvider(create: (_) => ProfileDetailsCubit.get()..fetchDetails()),
        BlocProvider(create: (_) => OrdersCubit.get()..fetchOrders()),
      ],
      child: MaterialApp(
        title: 'Pharma Connect',
        builder: FToastBuilder(),
        home: AppMainPage(),
      ),
    );
  }
}
