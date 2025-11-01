import 'package:flutter/material.dart';

class IncidentListScreen extends StatelessWidget {
  const IncidentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final incidents = [
      {'room': 'A101', 'type': 'Điện', 'status': 'Chờ xử lý'},
      {'room': 'C305', 'type': 'Nước', 'status': 'Đang xử lý'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sự cố'),
      ),
      body: ListView.builder(
        itemCount: incidents.length,
        itemBuilder: (context, index) {
          final incident = incidents[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Sự cố ${incident['type']} tại phòng ${incident['room']}'),
              trailing: Chip(label: Text(incident['status']!)),
              onTap: () {
                // TODO: Navigate to incident detail and assign staff
              },
            ),
          );
        },
      ),
    );
  }
}

