import 'package:flutter/material.dart';
import 'package:store_vendor_app_riverbod/service/VendorLocalService.dart';
import 'package:store_vendor_app_riverbod/provider/vendor_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckVendorState extends ConsumerStatefulWidget {
  const CheckVendorState({super.key});

  @override
  ConsumerState<CheckVendorState> createState() => _CheckVendorStateState();
}

class _CheckVendorStateState extends ConsumerState<CheckVendorState> {
  @override
  void initState() {
    super.initState();
    checkVendorStatus();
  }

  Future<void> checkVendorStatus() async {
    final token = await LocalStorageService().getToken();
    final vendor = await LocalStorageService().getVendor();

    if (token != null && vendor != null) {
      // ✅ ضع بيانات البائع في الـ Provider
      ref.read(vendorProvider.notifier).setVendor(vendor.toJson());

      // ✅ اذهب إلى Main Vendor Screen
      Navigator.pushReplacementNamed(context, '/vendor-dashboard');
    } else {
      // ❌ ليس مسجل دخول → اذهب إلى صفحة تسجيل الدخول
      Navigator.pushReplacementNamed(context, '/vendor-login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
