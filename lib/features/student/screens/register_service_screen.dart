import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/service_model.dart';

class RegisterServiceScreen extends StatefulWidget {
  const RegisterServiceScreen({super.key});

  @override
  State<RegisterServiceScreen> createState() => _RegisterServiceScreenState();
}

class _RegisterServiceScreenState extends State<RegisterServiceScreen> {
  // Mock Data
  final List<ServiceModel> _services = [
    ServiceModel(
      id: 'ser01',
      name: 'Dịch vụ giặt ủi',
      description: 'Giặt, sấy và ủi quần áo. Tính theo kg.',
      price: 15000,
      unit: 'kg',
    ),
    ServiceModel(
      id: 'ser02',
      name: 'Thuê tủ lạnh mini',
      description: 'Tủ lạnh 90L tiết kiệm điện cho phòng.',
      price: 150000,
      unit: 'tháng',
      status: ServiceStatus.Registered,
    ),
    ServiceModel(
      id: 'ser03',
      name: 'Dọn dẹp phòng',
      description: 'Dọn dẹp vệ sinh phòng ở 2 lần/tuần.',
      price: 200000,
      unit: 'tháng',
      status: ServiceStatus.Pending,
    ),
  ];

  void _registerForService(ServiceModel service) {
    setState(() {
      // Find the service in the list and update its status
      final index = _services.indexWhere((s) => s.id == service.id);
      if (index != -1) {
        _services[index] = service.copyWith(status: ServiceStatus.Pending);
      }
    });

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yêu cầu đã được gửi'),
        content: Text(
            'Yêu cầu đăng ký dịch vụ "${service.name}" của b���n đã được gửi đi. BQL sẽ sớm xem xét.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký dịch vụ'),
      ),
      body: ListView.builder(
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(service.name),
              subtitle: Text('${currencyFormat.format(service.price)} / ${service.unit}'),
              trailing: _buildStatusButton(service),
              onTap: () {
                _showServiceDetails(service);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusButton(ServiceModel service) {
    switch (service.status) {
      case ServiceStatus.Available:
        return ElevatedButton(
          onPressed: () {
            _registerForService(service);
          },
          child: const Text('Đăng ký'),
        );
      case ServiceStatus.Pending:
        return const Chip(
          label: Text('Chờ duyệt'),
          backgroundColor: Colors.orange,
          labelStyle: TextStyle(color: Colors.white),
        );
      case ServiceStatus.Registered:
        return const Chip(
          label: Text('Đã ĐK'),
          backgroundColor: Colors.green,
          labelStyle: TextStyle(color: Colors.white),
        );
    }
  }

  void _showServiceDetails(ServiceModel service) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.description),
            const SizedBox(height: 16),
            Text(
              'Giá: ${currencyFormat.format(service.price)} / ${service.unit}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Đóng'),
          ),
          if (service.status == ServiceStatus.Available)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the details dialog
                _registerForService(service);
              },
              child: const Text('Đăng ký'),
            ),
        ],
      ),
    );
  }
}
