class MyOrder {
  factory MyOrder.fromJson(Map<String, dynamic> json) {
    return MyOrder(
      orderId: json['id'],
      productId: json['product_id'],
      name: json['name'],
      image: json['image'],
      unit: json['unit'],
      createdOn: json['created_on'],
      deliveryDate: json['delivery_date'],
      orderBy: json['ordered_by'],
      status: json['status'],
    );
  }
  final String orderId;
  final String productId;
  final String name;
  final String image;
  final String status;
  final int unit;
  final String createdOn;
  final String deliveryDate;
  final String? orderBy;

  const MyOrder({
    required this.orderId,
    required this.productId,
    required this.name,
    required this.image,
    required this.unit,
    required this.status,
    required this.createdOn,
    required this.deliveryDate,
    this.orderBy,
  });
}
