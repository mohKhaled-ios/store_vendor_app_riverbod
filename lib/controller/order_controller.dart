// lib/services/order_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_vendor_app_riverbod/model/order_model.dart';

class OrderService {
  static const String baseUrl = 'http://192.168.1.3:5000/api/orders';

  // جلب طلبات البائع
  static Future<List<OrderModel>> getOrdersByVendor(String vendorId) async {
    final response = await http.get(Uri.parse('$baseUrl/vendor/$vendorId'));
    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في جلب طلبات البائع');
    }
  }

  // تحديث حالة طلب
  static Future<bool> updateStatus({
    required String orderId,
    required String status,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$orderId/status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );
    return response.statusCode == 200;
  }
}
