import 'package:pharma_connect/core/typedefs.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';

abstract interface class HomePageRepo {
  AsyncValueOf<List<SampleDrug>> fetchSampleDrugs();
}
