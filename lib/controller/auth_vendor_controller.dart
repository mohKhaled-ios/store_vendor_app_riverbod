// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:store_vendor_app_riverbod/model/vendor.dart';
// import 'package:store_vendor_app_riverbod/service/manage_http_response.dart';

// class VendorAuthController {
//   final String baseUrl =
//       "http://192.168.1.3:5000"; // عدلها إلى IP السيرفر عند الاختبار على جهاز حقيقي

//   /// تسجيل بائع جديد
//   Future<void> signupVendor({
//     required BuildContext context,
//     required String fullname,
//     required String email,
//     required String password,
//     required VoidCallback onSuccess,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$baseUrl/api/vendor/auth/signup'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'fullname': fullname,
//           'email': email,
//           'password': password,
//         }),
//       );

//       httpResponseHandler(
//         response: res,
//         context: context,
//         onSuccess: () {
//           onSuccess();
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   /// تسجيل دخول البائع
//   Future<void> signinVendor({
//     required BuildContext context,
//     required String email,
//     required String password,
//     required Function(String token, VendorModel vendor) onSuccess,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$baseUrl/api/vendor/auth/signin'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );

//       httpResponseHandler(
//         response: res,
//         context: context,
//         onSuccess: () {
//           final data = jsonDecode(res.body);
//           String token = data['token'];
//           VendorModel vendor = VendorModel.fromJson(data);
//           onSuccess(token, vendor);
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_vendor_app_riverbod/model/vendor.dart';
import 'package:store_vendor_app_riverbod/service/VendorLocalService.dart';

import 'package:store_vendor_app_riverbod/service/manage_http_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/provider/vendor_provider.dart';

class VendorAuthController {
  final String baseUrl = "http://192.168.1.3:5000";

  Future<void> signupVendor({
    required BuildContext context,
    required String fullname,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/vendor/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullname': fullname,
          'email': email,
          'password': password,
        }),
      );

      httpResponseHandler(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signinVendor({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
    required Function() onSuccess,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/vendor/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      httpResponseHandler(
        response: res,
        context: context,
        onSuccess: () async {
          final data = jsonDecode(res.body);
          String token = data['token'];
          VendorModel vendor = VendorModel.fromJson(data);

          /// ✅ حفظ التوكن محلياً
          await LocalStorageService().saveToken(token);

          /// ✅ حفظ بيانات البائع محلياً
          await LocalStorageService().saveVendor(vendor);

          /// ✅ وضع بيانات البائع في الـ Provider
          ref.read(vendorProvider.notifier).setVendor(vendor.toJson());

          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signOutVendor({required WidgetRef ref}) async {
    await LocalStorageService().clearToken();
    await LocalStorageService().clearVendor();
    ref.read(vendorProvider.notifier).signout();
  }
}
