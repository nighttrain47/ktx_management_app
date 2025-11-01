import 'package:flutter/material.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final invoices = [
      {'name': 'Hóa đơn tiền phòng T11/2025', 'amount': '2,000,000 VNĐ', 'status': 'Chưa thanh toán'},
      {'name': 'Hóa đơn điện T10/2025', 'amount': '150,000 VNĐ', 'status': 'Đã thanh toán'},
      {'name': 'Hóa đơn nước T10/2025', 'amount': '50,000 VNĐ', 'status': 'Đã thanh toán'},
      {'name': 'Hóa đơn dịch vụ giặt ủi T10/2025', 'amount': '150,000 VNĐ', 'status': 'Quá hạn'},
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case 'Đã thanh toán':
          return Colors.green;
        case 'Chưa thanh toán':
          return Colors.orange;
        case 'Quá hạn':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài chính & Thanh toán'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: ListTile(
              title: Text(invoice['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Số tiền: ${invoice['amount']}'),
              trailing: Chip(
                label: Text(invoice['status']!),
                backgroundColor: getStatusColor(invoice['status']!),
                labelStyle: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                // TODO: Navigate to invoice detail screen
              },
            ),
          );
        },
      ),
    );
  }
}

