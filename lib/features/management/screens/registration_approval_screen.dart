import 'package:flutter/material.dart';
import '../../../core/models/user_model.dart';

class RegistrationApprovalScreen extends StatefulWidget {
  const RegistrationApprovalScreen({super.key});

  @override
  _RegistrationApprovalScreenState createState() => _RegistrationApprovalScreenState();
}

class _RegistrationApprovalScreenState extends State<RegistrationApprovalScreen> {
  // Mock data
  final List<Map<String, dynamic>> _requests = [
    {'type': 'Đăng ký mới', 'user': UserModel(id: 'sv03', username: 'sv03', fullName: 'Trần Thị B', role: UserRole.student), 'date': DateTime.now()},
    {'type': 'Gia hạn hợp đồng', 'user': UserModel(id: 'sv04', username: 'sv04', fullName: 'Lê Văn C', role: UserRole.student), 'date': DateTime.now().subtract(const Duration(days: 1))},
  ];

  void _handleRequest(Map<String, dynamic> request, bool isApproved) {
    setState(() {
      _requests.remove(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã ${isApproved ? "duyệt" : "từ chối"} yêu cầu của ${request['user'].fullName}'),
        backgroundColor: isApproved ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xét duyệt đơn đăng ký'),
      ),
      body: _requests.isEmpty
          ? const Center(child: Text('Không có yêu cầu nào cần xét duyệt.'))
          : ListView.builder(
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(request['type'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Sinh viên: ${request['user'].fullName}'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.close, color: Colors.red),
                              label: const Text('Từ chối', style: TextStyle(color: Colors.red)),
                              onPressed: () => _handleRequest(request, false),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.check),
                              label: const Text('Duyệt'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: () => _handleRequest(request, true),
                            ),
                          ],
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
