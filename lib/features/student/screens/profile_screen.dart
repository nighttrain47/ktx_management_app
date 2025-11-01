import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    const studentInfo = {
      'name': 'Nguyễn Văn A',
      'studentId': '20181234',
      'class': 'CNTT-14',
      'faculty': 'Công nghệ thông tin',
      'room': 'A101',
    };
    const contractInfo = {
      'contractId': 'HD2025001',
      'startDate': '01/09/2025',
      'endDate': '01/09/2026',
      'price': '2,000,000 VNĐ/tháng',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân & Hợp đồng'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Thông tin cá nhân'),
            Card(
              elevation: 2,
              child: Column(
                children: studentInfo.entries
                    .map((e) => ListTile(
                          title: Text(e.key.replaceAll('_', ' ').toUpperCase()),
                          subtitle: Text(e.value, style: Theme.of(context).textTheme.titleMedium),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Thông tin hợp đồng'),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  ...contractInfo.entries
                      .map((e) => ListTile(
                            title: Text(e.key.replaceAll('_', ' ').toUpperCase()),
                            subtitle: Text(e.value, style: Theme.of(context).textTheme.titleMedium),
                          ))
                      .toList(),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement contract extension logic
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã gửi yêu cầu gia hạn hợp đồng!')),
                        );
                      },
                      child: const Text('Gửi yêu cầu gia hạn'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

