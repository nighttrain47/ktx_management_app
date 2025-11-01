import 'package:flutter/material.dart';
import 'package:ktx_management_app/features/security/screens/access_log_screen.dart';
import 'package:ktx_management_app/features/security/screens/guest_list_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SecurityDashboardScreen extends StatefulWidget {
  const SecurityDashboardScreen({super.key});

  @override
  State<SecurityDashboardScreen> createState() =>
      _SecurityDashboardScreenState();
}

class _SecurityDashboardScreenState extends State<SecurityDashboardScreen> {
  final TextEditingController _manualInputController = TextEditingController();

  void _onQRCodeDetected(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String code = barcodes.first.rawValue ?? 'Không có dữ liệu';
      _showStudentInfoDialog(code);
    }
  }

  void _showStudentInfoDialog(String studentId) {
    // Mock data
    const studentInfo = {
      'name': 'Nguyễn Văn A',
      'room': 'A101',
      'id': 'SV001',
      'imageUrl': 'https://via.placeholder.com/150' // Placeholder image
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông tin sinh viên'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(studentInfo['imageUrl']!),
            const SizedBox(height: 16),
            Text('Họ tên: ${studentInfo['name']}'),
            Text('Mã SV: $studentId'),
            Text('Phòng: ${studentInfo['room']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement check-in/out logic
              print('Checked in/out: $studentId');
              Navigator.pop(context);
            },
            child: const Text('Ghi nhận Ra/Vào'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điều khiển Bảo vệ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: _buildQRScanner(context),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: _buildManualCheckin(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.group),
              label: const Text('Xem danh sách khách thăm'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuestListScreen()),
                );
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text('Xem lịch sử ra vào'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccessLogScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRScanner(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: MobileScanner(
                onDetect: _onQRCodeDetected,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Hướng camera về phía mã QR của sinh viên'),
          ),
        ],
      ),
    );
  }

  Widget _buildManualCheckin(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Check-in/Check-out thủ công', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _manualInputController,
              decoration: const InputDecoration(
                labelText: 'Nhập MSSV',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_manualInputController.text.isNotEmpty) {
                  _showStudentInfoDialog(_manualInputController.text);
                }
              },
              child: const Text('Kiểm tra'),
            ),
          ],
        ),
      ),
    );
  }
}
