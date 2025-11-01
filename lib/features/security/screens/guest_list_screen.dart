import 'package:flutter/material.dart';

class GuestListScreen extends StatelessWidget {
  const GuestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final guests = [
      {'guestName': 'Trần Văn E', 'studentRoom': 'A101', 'visitDate': '31/10/2025'},
      {'guestName': 'Nguyễn Thị F', 'studentRoom': 'D402', 'visitDate': '01/11/2025'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách khách thăm'),
      ),
      body: ListView.builder(
        itemCount: guests.length,
        itemBuilder: (context, index) {
          final guest = guests[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Khách: ${guest['guestName']}'),
              subtitle: Text('Thăm phòng: ${guest['studentRoom']} - Ngày: ${guest['visitDate']}'),
            ),
          );
        },
      ),
    );
  }
}

