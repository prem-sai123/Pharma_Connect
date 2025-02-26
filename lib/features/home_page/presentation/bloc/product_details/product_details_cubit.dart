import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/home_page/model/product_details.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/locator/injector.dart';
import 'package:pharma_connect/model/failure.dart';

part 'product_details_cubit.freezed.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.repo) : super(_Initial());

  static ProductDetailsCubit get() => $sl.get<ProductDetailsCubit>();
  final HomePageRepo repo;

  void fetchDetails(SampleDrug drug) {
    emit(_Loading());
    final details = ProductDetails.fromSample(drug);
    emit(_Success(details));
  }
}

@freezed
class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;
  const factory ProductDetailsState.loading() = _Loading;
  const factory ProductDetailsState.success(ProductDetails details) = _Success;
  const factory ProductDetailsState.failure(Failure failure) = _Failure;
}
