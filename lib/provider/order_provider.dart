// lib/controllers/vendor_order_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/controller/order_controller.dart'
    show OrderService;
import 'package:store_vendor_app_riverbod/model/order_model.dart';

final vendorOrderProvider =
    StateNotifierProvider<VendorOrderController, List<OrderModel>>(
      (ref) => VendorOrderController(),
    );

class VendorOrderController extends StateNotifier<List<OrderModel>> {
  VendorOrderController() : super([]);

  Future<void> fetchVendorOrders(String vendorId) async {
    try {
      final orders = await OrderService.getOrdersByVendor(vendorId);
      state = orders;
    } catch (e) {
      state = [];
    }
  }

  Future<void> changeOrderStatus({
    required String orderId,
    required String vendorId,
    required String newStatus,
  }) async {
    final success = await OrderService.updateStatus(
      orderId: orderId,
      status: newStatus,
    );
    if (success) {
      // إعادة تحميل لتحديث الواجهة
      await fetchVendorOrders(vendorId);
    }
  }
}
