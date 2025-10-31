import 'package:flutter/material.dart';

class ManagementDrawer extends StatelessWidget {
  const ManagementDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'BQL Ký túc xá',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Trang chủ'),
            selected: currentRoute == '/management',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/management') {
                Navigator.pushReplacementNamed(context, '/management');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Quản lý Sinh viên'),
            selected: currentRoute == '/student-management',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/student-management') {
                Navigator.pushReplacementNamed(context, '/student-management');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Quản lý Tài chính'),
            selected: currentRoute == '/finance-management',
            onTap: () {
              Navigator.pop(context);
               if (currentRoute != '/finance-management') {
                Navigator.pushReplacementNamed(context, '/finance-management');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Quản lý Sự cố'),
            selected: currentRoute == '/incident-management',
            onTap: () {
               Navigator.pop(context);
               if (currentRoute != '/incident-management') {
                Navigator.pushReplacementNamed(context, '/incident-management');
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Gửi thông báo'),
            onTap: () {
              // TODO: Implement Send Notification Screen
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

