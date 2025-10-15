import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_vendor_app_riverbod/model/vendor.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _vendorKey = 'vendor_data';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// 📝 حفظ بيانات Vendor كاملة كـ JSON String
  Future<void> saveVendor(VendorModel vendor) async {
    final prefs = await SharedPreferences.getInstance();
    final vendorJson = jsonEncode(vendor.toJson());
    await prefs.setString(_vendorKey, vendorJson);
  }

  /// 📝 استرجاع بيانات Vendor
  Future<VendorModel?> getVendor() async {
    final prefs = await SharedPreferences.getInstance();
    final vendorJson = prefs.getString(_vendorKey);
    if (vendorJson != null) {
      final vendorMap = jsonDecode(vendorJson) as Map<String, dynamic>;
      return VendorModel.fromJson(vendorMap);
    }
    return null;
  }

  Future<void> clearVendor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_vendorKey);
  }
}
