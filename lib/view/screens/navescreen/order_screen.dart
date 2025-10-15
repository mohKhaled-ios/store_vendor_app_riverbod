// lib/views/screens/vendor_orders_screen.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:store_vendor_app_riverbod/provider/order_provider.dart';
import 'package:store_vendor_app_riverbod/provider/vendor_provider.dart';

class VendorOrdersScreen extends ConsumerStatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  ConsumerState<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends ConsumerState<VendorOrdersScreen> {
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final vendor = ref.read(vendorProvider);
    if (vendor == null || vendor.id.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(vendorOrderProvider.notifier).fetchVendorOrders(vendor.id);
    } catch (e) {
      _error = 'فشل في جلب الطلبات';
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Uint8List? _decodeImage(String src) {
    try {
      if (src.startsWith('http')) return null;
      return base64Decode(src);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(vendorOrderProvider);
    final vendor = ref.watch(vendorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلبات البائع'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadOrders),
        ],
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : orders.isEmpty
              ? const Center(child: Text('لا توجد طلبات حالياً'))
              : RefreshIndicator(
                onRefresh: _loadOrders,
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final imageData = _decodeImage(order.productImage);
                    final unitPrice = double.tryParse(order.productPrice) ?? 0;
                    final totalPrice = unitPrice * order.quantity;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // رأس الكارد: اسم المنتج + حالة
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    order.productName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Chip(
                                  backgroundColor: _statusColor(
                                    order.status,
                                  ).withOpacity(0.15),
                                  label: Text(
                                    order.status.toUpperCase(),
                                    style: TextStyle(
                                      color: _statusColor(order.status),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // صورة و تفاصيل
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child:
                                        imageData != null
                                            ? Image.memory(
                                              imageData,
                                              fit: BoxFit.cover,
                                            )
                                            : (order.productImage.startsWith(
                                                  'http',
                                                )
                                                ? Image.network(
                                                  order.productImage,
                                                  fit: BoxFit.cover,
                                                )
                                                : const Icon(
                                                  Icons.image_not_supported,
                                                  size: 40,
                                                  color: Colors.grey,
                                                )),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('الفئة: ${order.category}'),
                                      Text('الكمية: ${order.quantity}'),
                                      Text(
                                        'سعر الوحدة: ${unitPrice.toStringAsFixed(2)} ج.م',
                                      ),
                                      Text(
                                        'الإجمالي: ${totalPrice.toStringAsFixed(2)} ج.م',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // بيانات العميل و العنوان
                            Text('الاسم: ${order.fullName}'),
                            Text('البريد: ${order.email}'),
                            Text(
                              'العنوان: ${order.state} - ${order.city}, ${order.locality}',
                            ),
                            const SizedBox(height: 10),

                            // تغيير الحالة
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  value: order.status,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'pending',
                                      child: Text('قيد الانتظار'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'confirmed',
                                      child: Text('مؤكد'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'shipped',
                                      child: Text('تم الشحن'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'delivered',
                                      child: Text('تم التسليم'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'cancelled',
                                      child: Text('ملغي'),
                                    ),
                                  ],
                                  onChanged: (newStatus) async {
                                    if (newStatus == null ||
                                        newStatus == order.status)
                                      return;
                                    // تأكيد قبل التغيير
                                    final ok = await showDialog<bool>(
                                      context: context,
                                      builder:
                                          (_) => AlertDialog(
                                            title: const Text(
                                              'تأكيد تغيير الحالة',
                                            ),
                                            content: Text(
                                              'هل تريد تغيير حالة الطلب إلى "$newStatus"؟',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      false,
                                                    ),
                                                child: const Text('إلغاء'),
                                              ),
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      true,
                                                    ),
                                                child: const Text('تأكيد'),
                                              ),
                                            ],
                                          ),
                                    );
                                    if (ok != true) return;
                                    // تنفيذ التغيير
                                    await ref
                                        .read(vendorOrderProvider.notifier)
                                        .changeOrderStatus(
                                          orderId: order.id,
                                          vendorId: vendor?.id ?? '',
                                          newStatus: newStatus,
                                        );
                                    // إعادة تحميل تلقائي (مفعل داخل controller)
                                  },
                                ),
                                Text(
                                  DateFormat.yMMMd(
                                    'en_US',
                                  ).add_jm().format(order.orderDate),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
