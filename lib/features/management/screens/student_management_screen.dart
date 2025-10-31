import 'package:flutter/material.dart';
import '../../../core/models/user_model.dart';

class StudentManagementScreen extends StatelessWidget {
  const StudentManagementScreen({super.key});

  // Mock data
  final List<UserModel> _students = const [
    UserModel(id: 'sv01', username: 'sv01', fullName: 'Nguyễn Văn A', role: UserRole.student, room: 'P.101'),
    UserModel(id: 'sv02', username: 'sv02', fullName: 'Phạm Thị B', role: UserRole.student, room: 'P.102'),
    UserModel(id: 'sv03', username: 'sv03', fullName: 'Trần Văn C', role: UserRole.student, room: 'P.101'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Sinh viên'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(child: Text(student.fullName[0])),
              title: Text(student.fullName),
              subtitle: Text('MSSV: ${student.id} - Phòng: ${student.room}'),
              trailing: const Icon(Icons.chevron_right),
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
