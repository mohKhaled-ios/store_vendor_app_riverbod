import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:store_vendor_app_riverbod/model/ProductModel.dart';
import 'package:store_vendor_app_riverbod/service/manage_http_response.dart';

class ProductController {
  Future<void> addProduct({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.3:5000/api/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    httpResponseHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, 'تم إضافة المنتج بنجاح');
      },
    );
  }
}
