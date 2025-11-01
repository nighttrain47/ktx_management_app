import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/invoice_model.dart'; // Reusing Invoice for simplicity

class TransactionHistoryScreen extends StatelessWidget {
  // Mock data for transaction history
  final List<Invoice> _transactions = [
    Invoice(id: 'inv001', title: 'Thanh toán tiền phòng T10/2025', amount: 2500000, dueDate: DateTime(2025, 10, 4), status: InvoiceStatus.Paid),
    Invoice(id: 'inv005', title: 'Thanh toán tiền mạng T09/2025', amount: 100000, dueDate: DateTime(2025, 9, 3), status: InvoiceStatus.Paid),
    Invoice(id: 'inv006', title: 'Thanh toán tiền phòng T08/2025', amount: 2500000, dueDate: DateTime(2025, 8, 5), status: InvoiceStatus.Paid),
    Invoice(id: 'inv007', title: 'Thanh toán tiền điện T08/2025', amount: 450000, dueDate: DateTime(2025, 8, 5), status: InvoiceStatus.Paid),
  ];

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử giao dịch'),
      ),
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(transaction.title),
              subtitle: Text('Ngày thanh toán: ${DateFormat('dd/MM/yyyy').format(transaction.dueDate)}'),
              trailing: Text(
                currencyFormat.format(transaction.amount),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          );
        },
      ),
    );
  }
}
