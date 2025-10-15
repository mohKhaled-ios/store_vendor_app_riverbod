import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:store_vendor_app_riverbod/controller/product_controller.dart';
import 'package:store_vendor_app_riverbod/model/ProductModel.dart';
import 'package:store_vendor_app_riverbod/provider/vendor_provider.dart';

import 'dart:convert';

import 'package:store_vendor_app_riverbod/service/manage_http_response.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  List<File> images = [];
  String? selectedCategory;
  String? selectedSubCategory;
  List<dynamic> categories = [];
  List<dynamic> subcategories = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.3:5000/api/categories'),
    );
    if (response.statusCode == 200) {
      setState(() {
        categories = jsonDecode(response.body);
      });
    }
  }

  Future<void> fetchSubCategories(String categoryName) async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.1.3:5000/api/subcategories/category/$categoryName',
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        subcategories = jsonDecode(response.body);
      });
    }
  }

  Future<void> pickImages() async {
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        images = picked.map((e) => File(e.path)).toList();
      });
    }
  }

  Future<void> uploadProduct() async {
    if (!_formKey.currentState!.validate() ||
        selectedCategory == null ||
        selectedSubCategory == null ||
        images.isEmpty) {
      showSnackBar(context, 'أدخل جميع البيانات و الصورة');
      return;
    }
    final vendor = ref.read(vendorProvider);
    if (vendor == null || vendor.id.isEmpty) {
      showSnackBar(context, 'لم يتم تحميل بيانات البائع. سجل الدخول مجدداً.');
      return;
    }
    List<String> base64Images =
        images.map((img) => base64Encode(img.readAsBytesSync())).toList();

    ProductModel product = ProductModel(
      productName: nameController.text,
      productPrice: double.parse(priceController.text),
      quantity: int.parse(qtyController.text),
      description: descController.text,
      category: selectedCategory!,
      subcategory: selectedSubCategory!,
      images: base64Images,
      vendorId: vendor.id,
    );

    await ProductController().addProduct(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة منتج جديد')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المنتج',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'مطلوب' : null,
              ),
              SizedBox(height: 25),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'السعر',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'مطلوب' : null,
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الكمية',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'مطلوب' : null,
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'مطلوب' : null,
              ),
              SizedBox(height: 25),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                hint: const Text('اختر القسم'),
                items:
                    categories.map<DropdownMenuItem<String>>((cat) {
                      return DropdownMenuItem<String>(
                        value: cat['name'],
                        child: Text(cat['name']),
                      );
                    }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val!;
                    selectedSubCategory = null;
                    fetchSubCategories(val);
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedSubCategory,
                hint: const Text('اختر الفئة الفرعية'),
                items:
                    subcategories.map<DropdownMenuItem<String>>((sub) {
                      return DropdownMenuItem<String>(
                        value: sub['subcategoryname'],
                        child: Text(sub['subcategoryname']),
                      );
                    }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedSubCategory = val!;
                  });
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('اختر الصور'),
                onPressed: pickImages,
              ),
              const SizedBox(height: 10),
              Wrap(
                children:
                    images
                        .map((e) => Image.file(e, width: 100, height: 100))
                        .toList(),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: uploadProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // اللون الأزرق
                  ),
                  child: const Text(
                    'إضافة المنتج',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
