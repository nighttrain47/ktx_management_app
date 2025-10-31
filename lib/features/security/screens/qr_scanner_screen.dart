import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/models/user_model.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  void _showStudentInfoDialog(BuildContext context, String studentId, MobileScannerController controller) {
    // Stop scanning
    controller.stop();

    // Mock student data based on ID
    // In a real app, you'd fetch this from a service
    final user = UserModel(
      id: studentId,
      username: studentId, // Assuming username is the same as id for this mock
      fullName: 'Nguyễn Văn A (Mock)',
      role: UserRole.student,
      room: 'P.101',
    );

    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (context) => AlertDialog(
        title: const Text('Xác thực thành công'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              // Placeholder for image, as NetworkImage was causing issues without a valid URL
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 16),
            Text(user.fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('MSSV: ${user.id}'),
            Text('Phòng: ${user.room ?? "N/A"}'),
            const SizedBox(height: 8),
            Text('Check-in lúc: ${TimeOfDay.now().format(context)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Resume scanning
              controller.start();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    ).then((_) {
      // Ensure scanning resumes if dialog is dismissed by tapping outside
      controller.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = MobileScannerController();
    return Scaffold(
      appBar: AppBar(title: const Text('Quét mã QR')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  // Pause scanning before showing dialog
                  controller.stop();
                  _showStudentInfoDialog(context, code, controller);
                }
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
