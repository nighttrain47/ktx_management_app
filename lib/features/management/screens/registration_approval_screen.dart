import 'package:flutter/material.dart';

class RegistrationApprovalScreen extends StatelessWidget {
  const RegistrationApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final requests = [
      {'name': 'Lê Văn C', 'type': 'Đăng ký mới'},
      {'name': 'Hồ Thị D', 'type': 'Gia hạn hợp đồng'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Xét duyệt đơn đăng ký'),
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(request['name']!),
              subtitle: Text(request['type']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

