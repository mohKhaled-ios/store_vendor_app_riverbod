class VendorModel {
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  VendorModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['_id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      locality: json['locality'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'vendor',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
