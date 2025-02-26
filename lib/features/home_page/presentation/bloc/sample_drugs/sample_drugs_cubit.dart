import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/locator/injector.dart';
import 'package:pharma_connect/model/failure.dart';

part 'sample_drugs_cubit.freezed.dart';

@injectable
class SampleDrugsCubit extends Cubit<SampleDrugsState> {
  SampleDrugsCubit(this.repo) : super(_Initial());

  final HomePageRepo repo;

  static SampleDrugsCubit get() => $sl.get<SampleDrugsCubit>();
  
  void fetchSampleDrugs() async {
    emit(_Loading());
    final res = await repo.fetchSampleDrugs();
    emit(res.fold(_Failure.new, _Success.new));
  }
}

@freezed
class SampleDrugsState with _$SampleDrugsState {
  const factory SampleDrugsState.initial() = _Initial;
  const factory SampleDrugsState.loading() = _Loading;
  const factory SampleDrugsState.success(List<SampleDrug> data) = _Success;
  const factory SampleDrugsState.failure(Failure failure) = _Failure;
}
