import 'package:flutter/material.dart';
import 'package:ktx_management_app/features/student/screens/access_history_screen.dart';
import 'package:ktx_management_app/features/student/screens/finance_screen.dart';
import 'package:ktx_management_app/features/student/screens/guest_registration_screen.dart';
import 'package:ktx_management_app/features/student/screens/incident_report_screen.dart';
import 'package:ktx_management_app/features/student/screens/incident_tracking_screen.dart';
import 'package:ktx_management_app/features/student/screens/invoice_list_screen.dart';
import 'package:ktx_management_app/features/student/screens/notifications_screen.dart';
import 'package:ktx_management_app/features/student/screens/profile_screen.dart';
import 'package:ktx_management_app/features/student/screens/service_registration_screen.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ Sinh viên'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(context),
            const SizedBox(height: 24),
            Text(
              'Lối tắt chức năng',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildShortcutGrid(context),
            const SizedBox(height: 24),
            _buildNotificationsSection(context),
            const SizedBox(height: 24),
            _buildInvoicesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    // Mock data
    const studentName = 'Nguyễn Văn A';
    const roomNumber = 'A101';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 30),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chào mừng, $studentName',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Phòng: $roomNumber',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // Changed to 3 for better layout
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildShortcutItem(
          context,
          icon: Icons.payment,
          label: 'Thanh toán',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FinanceScreen()),
            );
          },
        ),
        _buildShortcutItem(
          context,
          icon: Icons.report_problem,
          label: 'Báo cáo sự cố',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IncidentReportScreen()),
            );
          },
        ),
        _buildShortcutItem(
          context,
          icon: Icons.room_service,
          label: 'Đăng ký dịch vụ',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ServiceRegistrationScreen()),
            );
          },
        ),
        _buildShortcutItem(
          context,
          icon: Icons.group_add,
          label: 'Đăng ký khách',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const GuestRegistrationScreen()),
            );
          },
        ),
        _buildShortcutItem(
          context,
          icon: Icons.history,
          label: 'Lịch sử ra vào',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AccessHistoryScreen()),
            );
          },
        ),
        _buildShortcutItem(
          context,
          icon: Icons.track_changes,
          label: 'Theo dõi sự cố',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IncidentTrackingScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildShortcutItem(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(BuildContext context) {
    // Mock data
    final notifications = [
      'BQL thông báo lịch cắt nước từ 8h-10h sáng mai.',
      'Vui lòng kiểm tra lại thông tin hợp đồng trước ngày 30/11.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông báo mới (2)',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: notifications
                .map((e) => ListTile(
                      leading: const Icon(Icons.info, color: Colors.blue),
                      title: Text(e),
                      onTap: () {},
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInvoicesSection(BuildContext context) {
    // Mock data
    final invoices = [
      {'name': 'Tiền phòng tháng 11', 'due': 'Sắp hết hạn'},
      {'name': 'Tiền điện tháng 10', 'due': 'Quá hạn'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hóa đơn cần thanh toán',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: invoices
                .map((invoice) => ListTile(
                      leading: const Icon(Icons.receipt, color: Colors.orange),
                      title: Text(invoice['name']!),
                      trailing: Text(
                        invoice['due']!,
                        style: TextStyle(
                          color: invoice['due'] == 'Quá hạn'
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InvoiceListScreen()),
                        );
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
