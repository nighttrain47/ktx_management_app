import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ktx_management_app/features/management/screens/incident_list_screen.dart';
import 'package:ktx_management_app/features/management/screens/management_finance_screen.dart';
import 'package:ktx_management_app/features/management/screens/room_management_screen.dart';
import 'package:ktx_management_app/features/management/screens/send_notification_screen.dart';
import 'package:ktx_management_app/features/management/screens/service_management_screen.dart';
import 'package:ktx_management_app/features/management/screens/registration_approval_screen.dart';
import 'package:ktx_management_app/features/management/screens/student_list_screen.dart';

class ManagementDashboardScreen extends StatelessWidget {
  const ManagementDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điều khiển BQL'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatistics(context),
            const SizedBox(height: 24),
            _buildOccupancyChart(context),
            const SizedBox(height: 24),
            _buildPendingRequests(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _buildStatCard(context, 'Sinh viên', '1,250', Icons.people, Colors.blue,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StudentListScreen()),
          );
        }),
        _buildStatCard(
            context, 'Quản lý phòng', '...', Icons.bed, Colors.green,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RoomManagementScreen()),
          );
        }),
        _buildStatCard(
            context, 'Đơn đăng ký mới', '15', Icons.new_releases, Colors.orange,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RegistrationApprovalScreen()),
          );
        }),
        _buildStatCard(
            context, 'Sự cố chưa xử lý', '8', Icons.report_problem, Colors.red,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IncidentListScreen()),
          );
        }),
        _buildStatCard(
            context, 'Tài chính', '...', Icons.monetization_on, Colors.purple,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ManagementFinanceScreen()),
          );
        }),
        _buildStatCard(
            context, 'Dịch vụ', '...', Icons.room_service, Colors.teal,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ServiceManagementScreen()),
          );
        }),
        _buildStatCard(
            context, 'Gửi thông báo', '...', Icons.send, Colors.lightBlue,
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SendNotificationScreen()),
          );
        }),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color,
      {VoidCallback? onTap}) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(title, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOccupancyChart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tỷ lệ lấp đầy',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Tòa A';
                              break;
                            case 1:
                              text = 'Tòa B';
                              break;
                            case 2:
                              text = 'Tòa C';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return SideTitleWidget(
                              axisSide: meta.axisSide, child: Text(text, style: style));
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _makeGroupData(0, 95), // Tòa A 95%
                    _makeGroupData(1, 80), // Tòa B 80%
                    _makeGroupData(2, 90), // Tòa C 90%
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

   BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.amber,
          width: 22,
          borderRadius: BorderRadius.circular(4)
        ),
      ],
    );
  }


  Widget _buildPendingRequests(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yêu cầu đang chờ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.blue),
                title: const Text('Xét duyệt đơn đăng ký'),
                trailing: const Chip(
                  label: Text('15'),
                  backgroundColor: Colors.blue,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationApprovalScreen()),
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.build, color: Colors.red),
                title: const Text('Xử lý sự cố'),
                trailing: const Chip(
                  label: Text('8'),
                  backgroundColor: Colors.red,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IncidentListScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
