import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_vendor_app_riverbod/view/screens/navescreen/add_product_screen.dart';
import 'package:store_vendor_app_riverbod/view/screens/navescreen/earning_screen.dart';
import 'package:store_vendor_app_riverbod/view/screens/navescreen/edit_screen.dart';
import 'package:store_vendor_app_riverbod/view/screens/navescreen/order_screen.dart';
import 'package:store_vendor_app_riverbod/view/screens/navescreen/profile_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    EarningVendorScreen(),
    AddProductScreen(),
    EditScreen(),
    VendorOrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.purple,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle),
            label: 'Upload',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'profile'),
        ],
      ),
    );
  }
}
