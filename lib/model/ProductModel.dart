// class ProductModel {
//   final String productName;
//   final double productPrice;
//   final int quantity;
//   final String description;
//   final String category;
//   final String subcategory;
//   final List<String> images;

//   ProductModel({
//     required this.productName,
//     required this.productPrice,
//     required this.quantity,
//     required this.description,
//     required this.category,
//     required this.subcategory,
//     required this.images,
//   });

//   Map<String, dynamic> toJson() => {
//     'productName': productName,
//     'productPrice': productPrice,
//     'quantity': quantity,
//     'description': description,
//     'category': category,
//     'subcategory': subcategory,
//     'images': images,
//   };
// }

class ProductModel {
  final String productName;
  final double productPrice;
  final int quantity;
  final String description;
  final String category;
  final String subcategory;
  final List<String> images;
  final String vendorId;

  ProductModel({
    required this.vendorId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.images,
  });

  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     id: json['_id'],
  //     productName: json['productName'],
  //     productPrice: (json['productPrice'] as num).toDouble(),
  //     quantity: json['quantity'],
  //     description: json['description'],
  //     category: json['category'],
  //     subcategory: json['subcategory'],
  //     images: List<String>.from(json['images']),
  //     popular: json['popular'],
  //     recommend: json['recommend'],
  //     vendorId: json['vendorId'],
  //     createdAt: DateTime.parse(json['createdAt']),
  //     updatedAt: DateTime.parse(json['updatedAt']),
  //   );
  // }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['productName'] ?? '',
      productPrice: (json['productPrice'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'] ?? '',
      images:
          json['images'] != null
              ? List<String>.from(json['images'])
              : <String>[],

      vendorId: json['vendorId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'images': images,
      'vendorId': vendorId,
    };
  }
}
