import 'package:equatable/equatable.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';

class ProductDetails extends Equatable {
  factory ProductDetails.fromSample(SampleDrug drug) {
    return ProductDetails(
      id: drug.id,
      image: drug.image,
      name: drug.name,
      info:
          '${drug.name} Blood Pressure Machine is a fully automatic digital blood pressure monitor device that enables a high-speed and reliable measurement of systolic and diastolic blood pressure as well as the pulse through the oscillometric method.',
      maxUnits: drug.units,
      uses: const [
        'It is used for measuring the blood pressure of individuals',
      ],
      directions: const ['Use as directed on the label'],
      safetyInfo: [
        'Store in a cool and dry place away from direct sunlight',
        'Read the product manual carefully before use',
        'Keep out of reach of children',
      ],
      featAndSpecs: const [
        'It has a portable design which makes it easy to carry anywhere at any time',
        'It has a automatic shutdown function which saves power',
        'It can support 2 users at a time with 120 memories each',
        'It helps to measure irregular heartbeat as well',
        'It comes with a large LED display',
        'It has dual power modes i.e. it is chargeable with a USB power source or it can be powered with 4 AA alkaline batteries',
        'It has an average value function that helps to analyse blood pressure variation',
        'It has a one button easy operation',
      ],
    );
  }
  final String id;
  final String name;
  final String image;
  final String info;
  final int maxUnits;
  final List<String> uses;
  final List<String> directions;
  final List<String> safetyInfo;
  final List<String> featAndSpecs; // Features And Specifications

  const ProductDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.info,
    required this.maxUnits,
    required this.uses,
    required this.directions,
    required this.safetyInfo,
    required this.featAndSpecs,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    info,
    maxUnits,
    uses,
    directions,
    safetyInfo,
    featAndSpecs,
  ];
}
