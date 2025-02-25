import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/core/typedefs.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/model/failure.dart';

@LazySingleton(as: HomePageRepo)
class HomePageRepoImpl implements HomePageRepo {
  final FirebaseFirestore db;
  const HomePageRepoImpl({required this.db});

  @override
  AsyncValueOf<List<SampleDrug>> fetchSampleDrugs() async {
    try {
      final collectionRef = db.collection('sample_drugs');
      final data = await collectionRef.orderBy(FieldPath.documentId).get();
      final sampleDrugs =
          data.docs.map((e) => SampleDrug.fromJson(e.id, e.data())).toList();
      sampleDrugs.sort((a, b) => a.id.compareTo(b.id));
      return right(sampleDrugs);
    } on Exception catch (e, _) {
      final failure = Failure(error: e.toString());
      return left(failure);
    }
  }
}
