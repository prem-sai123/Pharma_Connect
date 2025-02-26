import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/features/cart/model/cart.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/my_orders/model/my_order.dart';
import 'package:pharma_connect/locator/injector.dart';
import 'package:pharma_connect/model/failure.dart' show Failure;

part 'create_order_cubit.freezed.dart';

@injectable
class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this.repo) : super(_Initial());

  final HomePageRepo repo;

  static CreateOrderCubit get() => $sl.get<CreateOrderCubit>();

  void createOrder(Cart cart) async {
    emit(_Loading());
    final isLoggedIn = await repo.isLoggedIn();
    if (!isLoggedIn) return emit(_Login(cart));
    final res = await repo.createOrder(cart);
    emit(res.fold(_Failure.new, _Success.new));
  }
}

@freezed
class CreateOrderState with _$CreateOrderState {
  const factory CreateOrderState.initial() = _Initial;
  const factory CreateOrderState.loading() = _Loading;
  const factory CreateOrderState.login(Cart cart) = _Login;
  const factory CreateOrderState.success(MyOrder data) = _Success;
  const factory CreateOrderState.failure(Failure failure) = _Failure;
}
