import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pharma_connect/core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/features/cart/model/cart.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/features/my_orders/model/my_order.dart';
import 'package:pharma_connect/features/profile/model/user_details.dart';
import 'package:pharma_connect/model/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: HomePageRepo)
class HomePageRepoImpl implements HomePageRepo {
  final FirebaseFirestore db;
  final SharedPreferences pref;
  const HomePageRepoImpl({required this.db, required this.pref});

  @override
  Future<bool> isLoggedIn() async {
    try {
      final userId = pref.getString(Entites.userId);
      return userId != null;
    } catch (e) {
      return false;
    }
  }

  @override
  AsyncValueOf<List<SampleDrug>> fetchSampleDrugs() async {
    try {
      final collectionRef = db.collection(Entites.sampleDrugs);
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

  @override
  AsyncValueOf<MyOrder> createOrder(Cart cart) async {
    try {
      final collectionRef = db.collection(Entites.orders);
      final countSnapshot = await collectionRef.count().get();
      final count = (countSnapshot.count ?? 0) + 1;
      final orderId = count.toString();
      final jsonMap = cart.toJson();
      jsonMap['id'] = orderId;
      final userId = pref.getString(Entites.userId);
      if (userId != null) jsonMap['ordered_by'] = userId;
      final documentResult = await collectionRef.add(jsonMap);
      final orderData = await documentResult.get();
      return right(MyOrder.fromJson(orderData.data()!));
    } on Exception catch (e, _) {
      final failure = Failure(error: e.toString());
      return left(failure);
    }
  }

  @override
  AsyncValueOf<List<MyOrder>> fetchOrders() async {
    try {
      final userId = pref.getString(Entites.userId);
      if (userId == null) return right(<MyOrder>[]);

      final query = db
          .collection(Entites.orders)
          .where('is_active', isEqualTo: true);

      final data = await query.where('ordered_by', isEqualTo: userId).get();

      final sampleDrugs =
          data.docs.map((e) => MyOrder.fromJson(e.data())).toList();
      return right(sampleDrugs);
    } on Exception catch (e, _) {
      final failure = Failure(error: e.toString());
      return left(failure);
    }
  }

  @override
  Future<UserDetails?> fetchUser() async {
    try {
      final userId = pref.getString(Entites.userId);
      if (userId != null) {
        final document = db.collection(Entites.users).doc(userId);
        final docSnapshot = await document.get();
        final jsonData = docSnapshot.data();
        if (jsonData != null) return UserDetails.fromJson(jsonData);
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  AsyncValueOf<String> addOrUpdateUser(UserDetails user) async {
    try {
      final userId = pref.getString(Entites.userId);
      if (userId != null) {
        await _updateUser(userId, user);
      } else {
        await _addUser(user);
      }
      return right('Updated User Details Successfully');
    } catch (e) {
      final failure = Failure(error: e.toString());
      return left(failure);
    }
  }

  Future<void> _addUser(UserDetails user) async {
    try {
      final collectionRef = db.collection(Entites.users);
      final documentResult = await collectionRef.add(user.toJson());
      await pref.setString(Entites.userId, documentResult.id);
    } on Exception catch (e, _) {}
  }

  Future<void> _updateUser(String id, UserDetails user) async {
    try {
      final document = db.collection(Entites.users).doc(id);
      await document.update(user.toJson());
    } on Exception catch (e, _) {}
  }
}
