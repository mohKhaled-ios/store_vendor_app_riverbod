// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:store_vendor_app_riverbod/view/main_vendor_screen.dart';
// import 'package:store_vendor_app_riverbod/view/screens/authanticationscreen/login_screen.dart';
// import 'package:store_vendor_app_riverbod/view/screens/authanticationscreen/register_screen.dart';

// void main() {b
//   runApp(
//     ProviderScope(
//       child: MyApp(), // أو اسم الـ class الرئيسي لديك
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       routes: {
//         '/vendor-login': (context) => const VendorLoginScreen(),
//         '/vendor-register': (context) => const VendorRegisterScreen(),
//         '/vendor-dashboard':
//             (context) => const MainVendorScreen(), // تُنشئها لاحقًا
//       },
//       home: VendorLoginScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/view/CheckVendorState.dart';
import 'package:store_vendor_app_riverbod/view/main_vendor_screen.dart';
import 'package:store_vendor_app_riverbod/view/screens/authanticationscreen/login_screen.dart';
import 'package:store_vendor_app_riverbod/view/screens/authanticationscreen/register_screen.dart';
// ✅ صفحة فحص الحالة

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/vendor-login': (context) => const VendorLoginScreen(),
        '/vendor-register': (context) => const VendorRegisterScreen(),
        '/vendor-dashboard': (context) => const MainVendorScreen(),
      },
      home:
          const CheckVendorState(), // ✅ هنا يتم التوجيه الذكي بناءً على الحالة
    );
  }
}
