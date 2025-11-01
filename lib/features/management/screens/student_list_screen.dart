import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final students = [
      {'name': 'Nguyễn Văn A', 'id': '20181234', 'room': 'A101'},
      {'name': 'Trần Thị B', 'id': '20195678', 'room': 'B205'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sinh viên'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(student['name']!),
              subtitle: Text('MSSV: ${student['id']} - Phòng: ${student['room']}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: Navigate to student detail screen
              },
            ),
          );
        },
      ),
    );
  }
}

