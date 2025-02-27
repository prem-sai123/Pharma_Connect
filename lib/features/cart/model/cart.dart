import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';

class Cart extends Equatable {
  final int index;
  final SampleDrug drug;
  final int units;
  final DateTime dateTime;

  const Cart({
    required this.index,
    required this.drug,
    required this.units,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
    'product_id': drug.id,
    'name': drug.name,
    'image': drug.image,
    'unit': units,
    'status': 'Order Placed',
    'is_active': true,
    'created_on': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    'delivery_date': DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now().add(const Duration(days: 12))),
  };

  @override
  List<Object?> get props => [index, drug, units, dateTime];
}
