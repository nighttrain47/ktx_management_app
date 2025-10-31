import 'package:flutter/material.dart';

class GuestListScreen extends StatelessWidget {
  const GuestListScreen({super.key});

  // Mock data
  final List<Map<String, dynamic>> _guests = const [
    {'guestName': 'Trần Văn D', 'studentName': 'Nguyễn Văn A', 'room': 'P.101', 'visitDate': '31/10/2025'},
    {'guestName': 'Lê Thị E', 'studentName': 'Phạm Thị B', 'room': 'P.102', 'visitDate': '01/11/2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách khách thăm'),
      ),
      body: ListView.builder(
        itemCount: _guests.length,
        itemBuilder: (context, index) {
          final guest = _guests[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.person_pin_circle_outlined, color: Colors.blue),
              title: Text('Khách: ${guest['guestName']}'),
              subtitle: Text('Thăm sinh viên: ${guest['studentName']} - Phòng: ${guest['room']}'),
              trailing: Text('Ngày: ${guest['visitDate']}'),
            ),
          );
        },
      ),
    );
  }
}
