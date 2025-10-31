import 'package:flutter/material.dart';
import '../../../core/models/service_model.dart';

class ServiceManagementScreen extends StatefulWidget {
  const ServiceManagementScreen({super.key});

  @override
  _ServiceManagementScreenState createState() => _ServiceManagementScreenState();
}

class _ServiceManagementScreenState extends State<ServiceManagementScreen> {
  // Mock data
  final List<ServiceModel> _requests = [
    ServiceModel(id: 'req01', name: 'Dọn dẹp phòng', description: 'Yêu cầu dọn dẹp phòng', unit: 'tháng', price: 200000, status: ServiceStatus.Pending),
    ServiceModel(id: 'req02', name: 'Dịch vụ giặt ủi', description: 'Yêu cầu giặt ủi', unit: 'kg', price: 15000, status: ServiceStatus.Pending),
  ];

  void _handleRequest(ServiceModel request, bool isApproved) {
    setState(() {
      _requests.remove(request);
    });
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã ${isApproved ? "phê duyệt" : "từ chối"} dịch vụ ${request.name}'),
        backgroundColor: isApproved ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý dịch vụ'),
      ),
      body: _requests.isEmpty
          ? const Center(child: Text('Không có yêu cầu đăng ký dịch vụ nào.'))
          : ListView.builder(
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(request.name),
                    subtitle: const Text('Sinh viên: Nguyễn Văn A - P.101'), // Mock student
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => _handleRequest(request, false),
                        ),
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _handleRequest(request, true),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
