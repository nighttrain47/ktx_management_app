import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/invoice_model.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết hóa đơn'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Trạng thái:', _getStatusText(invoice.status),
                        color: _getStatusColor(invoice.status)),
                    _buildInfoRow('Số tiền:', currencyFormat.format(invoice.amount)),
                    _buildInfoRow('Hạn thanh toán:',
                        DateFormat('dd/MM/yyyy').format(invoice.dueDate)),
                    const Divider(height: 32),
                    // Mock detail data
                    _buildInfoRow('Chỉ số cũ:', '1234 kWh'),
                    _buildInfoRow('Chỉ số mới:', '1334 kWh'),
                    _buildInfoRow('Tiêu thụ:', '100 kWh'),
                    _buildInfoRow('Đơn giá:', '3,500 VNĐ/kWh'),
                    const Divider(height: 32),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Tổng cộng: ${currencyFormat.format(invoice.amount)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (invoice.status != InvoiceStatus.Paid)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Xác nhận đã chuyển khoản'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Xác nhận thanh toán'),
                        content: const Text(
                            'Yêu cầu của bạn đã được gửi. Ban quản lý sẽ kiểm tra và cập nhật trạng thái sớm nhất.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Đóng'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.Paid:
        return 'Đã thanh toán';
      case InvoiceStatus.Unpaid:
        return 'Chưa thanh toán';
      case InvoiceStatus.Overdue:
        return 'Quá hạn';
    }
  }

  Color _getStatusColor(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.Paid:
        return Colors.green;
      case InvoiceStatus.Unpaid:
        return Colors.orange;
      case InvoiceStatus.Overdue:
        return Colors.red;
    }
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value,
              style: TextStyle(
                  color: color, fontWeight: color != null ? FontWeight.bold : null)),
        ],
      ),
    );
  }
}
