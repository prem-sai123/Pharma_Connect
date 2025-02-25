import 'package:flutter/material.dart';
import 'package:pharma_connect/core/widgets/simple_app_bar.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/sample_drugs_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'PharmaConnect'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: SampleDrugsList(),
      ),
    );
  }
}
