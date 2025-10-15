import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/model/vendor.dart';

class VendorProvider extends StateNotifier<VendorModel?> {
  VendorProvider()
    : super(
        VendorModel(
          id: '',
          fullname: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          role: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

  VendorModel? get vendor => state;

  void setVendorFromJson(String vendorjson) {
    final decodedJson = jsonDecode(vendorjson) as Map<String, dynamic>;
    state = VendorModel.fromJson(decodedJson);
  }

  void setVendor(Map<String, dynamic> vendorMap) {
    state = VendorModel.fromJson(vendorMap);
  }

  void signout() {
    state = null;
  }
}

final vendorProvider = StateNotifierProvider<VendorProvider, VendorModel?>((
  ref,
) {
  return VendorProvider();
});
