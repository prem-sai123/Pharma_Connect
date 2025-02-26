import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/features/cart/model/cart.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';

class AddToCartCubit extends Cubit<List<Cart>> {
  AddToCartCubit() : super(<Cart>[]);

  void addToCart(SampleDrug drug, int count) {
    final index = state.length + 1;
    final cart = Cart(
      index: index,
      drug: drug,
      units: count,
      dateTime: DateTime.now(),
    );
    final items = [...state, cart];
    emit(items);
  }

  void remove(int id) {
    final items = [...state]..removeWhere((e) => e.index == id);
    emit(items);
  }
}
