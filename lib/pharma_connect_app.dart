import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/features/home_page/presentation/bloc/sample_drugs/sample_drugs_cubit.dart';
import 'package:pharma_connect/features/home_page/presentation/home_page.dart';

class PharmaConnectApp extends StatelessWidget {
  const PharmaConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharma Connect',
      home: BlocProvider(
        create: (_) => SampleDrugsCubit.get()..fetchSampleDrugs(),
        child: HomePage(),
      ),
    );
  }
}
