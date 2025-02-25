import 'package:equatable/equatable.dart';

class SampleDrug extends Equatable {
  factory SampleDrug.fromJson(String id, Map<String, dynamic> json) {
    return SampleDrug(
      id: json['id'],
      name: json['name'],
      units: json['units'],
      image: json['image'],
    );
  }
  
  final String id;
  final String name;
  final int units;
  final String image;

  const SampleDrug({
    required this.id,
    required this.name,
    required this.units,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, units, image];
}
