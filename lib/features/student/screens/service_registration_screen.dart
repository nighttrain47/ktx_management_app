import 'package:flutter/material.dart';

class ServiceRegistrationScreen extends StatelessWidget {
  const ServiceRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final services = [
      {'name': 'Dịch vụ giặt ủi (theo tháng)', 'price': '150,000 VNĐ/tháng'},
      {'name': 'Thuê tủ lạnh mini', 'price': '100,000 VNĐ/tháng'},
      {'name': 'Dọn vệ sinh phòng (1 lần/tuần)', 'price': '200,000 VNĐ/tháng'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký dịch vụ cộng thêm'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: ListTile(
              title: Text(service['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Giá: ${service['price']}'),
              trailing: ElevatedButton(
                child: const Text('Đăng ký'),
                onPressed: () {
                  // TODO: Implement registration logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã gửi yêu cầu đăng ký dịch vụ: ${service['name']}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

