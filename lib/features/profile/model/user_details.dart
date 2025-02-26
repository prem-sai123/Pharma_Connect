class UserDetails {
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      greetings: json['greetings'],
      phone: json['phone'],
      email: json['email_address'],
      address: json['billing_address'],
      practionerId: json['practioner_id'],
    );
  }
  final String name;
  final String? greetings;
  final String? phone;
  final String? email;
  final String? address;
  final String? practionerId;

  const UserDetails({
    required this.name,
    required this.greetings,
    this.phone,
    this.email,
    this.address,
    this.practionerId,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'greetings': greetings ?? '',
    'phone': phone,
    'email_address' : email,
    'billing_address': address,
    'practioner_id': practionerId,
  };
}
