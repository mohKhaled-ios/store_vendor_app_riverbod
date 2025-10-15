// lib/provider/total_earning_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/model/order_model.dart';
import 'package:store_vendor_app_riverbod/provider/order_provider.dart';

/// لحساب إجمالي الأرباح
final totalEarningProvider = Provider<double>((ref) {
  final orders = ref.watch(vendorOrderProvider);
  double total = 0.0;

  for (OrderModel order in orders) {
    final price = double.tryParse(order.productPrice) ?? 0;
    total += price * order.quantity;
  }

  return total;
});

/// لحساب عدد الطلبات
final totalOrderProvider = Provider<int>((ref) {
  final orders = ref.watch(vendorOrderProvider);
  return orders.length;
});
