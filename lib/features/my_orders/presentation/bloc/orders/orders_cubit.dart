import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/my_orders/model/my_order.dart';
import 'package:pharma_connect/locator/injector.dart';
import 'package:pharma_connect/model/failure.dart';

part 'orders_cubit.freezed.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repo) : super(_Initial());

  final HomePageRepo repo;

  static OrdersCubit get() => $sl.get<OrdersCubit>();
  void fetchOrders() async {
    emit(_Loading());
    final res = await repo.fetchOrders();
    emit(res.fold(_Failure.new, _Success.new));
  }
}

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.loading() = _Loading;
  const factory OrdersState.success(List<MyOrder> data) = _Success;
  const factory OrdersState.failure(Failure failure) = _Failure;
}
