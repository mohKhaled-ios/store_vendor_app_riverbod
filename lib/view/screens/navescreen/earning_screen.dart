// // lib/views/screens/earning_vendor_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:store_vendor_app_riverbod/provider/vendor_provider.dart';
// import 'package:store_vendor_app_riverbod/provider/total_earning_provider.dart';

// class EarningVendorScreen extends ConsumerWidget {
//   const EarningVendorScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final vendor = ref.watch(vendorProvider);
//     final totalEarnings = ref.watch(totalEarningProvider);
//     final totalOrders = ref.watch(totalOrderProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('لوحة البائع'),
//         backgroundColor: Colors.green,
//       ),
//       body: vendor == null
//           ? const Center(child: Text('لا يوجد بيانات للبائع'))
//           : Padding(
//               padding: const EdgeInsets.all(16),
//               child: ListView(
//                 children: [
//                   _buildSectionTitle('معلومات البائع'),
//                   _buildInfoTile('الاسم الكامل', vendor.fullname),
//                   _buildInfoTile('البريد الإلكتروني', vendor.email),
//                   _buildInfoTile('العنوان',
//                       '${vendor.state}, ${vendor.city}, ${vendor.locality}'),
//                   const SizedBox(height: 24),
//                   _buildSectionTitle('إحصائيات'),
//                   _buildStatTile('عدد الطلبات', '$totalOrders'),
//                   _buildStatTile('إجمالي الأرباح', '$totalEarnings ج.م'),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildInfoTile(String label, String value) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Text(label),
//       subtitle: Text(value),
//     );
//   }

//   Widget _buildStatTile(String label, String value) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       elevation: 2,
//       child: ListTile(
//         title: Text(label),
//         trailing: Text(
//           value,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/model/vendor.dart';
import 'package:store_vendor_app_riverbod/provider/total_earning_provider.dart';
import 'package:store_vendor_app_riverbod/provider/vendor_provider.dart';
import 'package:store_vendor_app_riverbod/provider/order_provider.dart';

class EarningVendorScreen extends ConsumerStatefulWidget {
  const EarningVendorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EarningVendorScreen> createState() =>
      _EarningVendorScreenState();
}

class _EarningVendorScreenState extends ConsumerState<EarningVendorScreen> {
  @override
  void initState() {
    super.initState();

    final vendor = ref.read(vendorProvider);
    if (vendor != null) {
      ref.read(vendorOrderProvider.notifier).fetchVendorOrders(vendor.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vendor = ref.watch(vendorProvider);
    final totalEarning = ref.watch(totalEarningProvider);
    final totalOrders = ref.watch(totalOrderProvider);

    if (vendor == null) {
      return const Center(child: Text('لا يوجد بيانات للبائع'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings & Vendor Info'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🧑 بيانات البائع',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('الاسم:', vendor.fullname),
              _buildInfoRow('البريد الإلكتروني:', vendor.email),
              _buildInfoRow('المنطقة:', vendor.state),
              _buildInfoRow('المدينة:', vendor.city),
              _buildInfoRow('الموقع المحلي:', vendor.locality),

              const SizedBox(height: 24),
              const Text(
                '📊 الإحصائيات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('عدد الطلبات:', '$totalOrders'),
              _buildInfoRow(
                'إجمالي الأرباح:',
                '${totalEarning.toStringAsFixed(2)} ج.م',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
