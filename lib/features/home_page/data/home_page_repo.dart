import 'package:pharma_connect/core/typedefs.dart';
import 'package:pharma_connect/features/cart/model/cart.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/features/my_orders/model/my_order.dart'
    show MyOrder;
import 'package:pharma_connect/features/profile/model/user_details.dart';

abstract interface class HomePageRepo {
  Future<bool> isLoggedIn();
  AsyncValueOf<List<SampleDrug>> fetchSampleDrugs();
  AsyncValueOf<List<MyOrder>> fetchOrders();
  AsyncValueOf<MyOrder> createOrder(Cart cart);

  Future<UserDetails?> fetchUser();
  AsyncValueOf<String> addOrUpdateUser(UserDetails user);
}
