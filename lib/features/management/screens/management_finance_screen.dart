import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/invoice_model.dart';
import '../widgets/management_drawer.dart';

class ManagementFinanceScreen extends StatefulWidget {
  const ManagementFinanceScreen({super.key});

  @override
  _ManagementFinanceScreenState createState() => _ManagementFinanceScreenState();
}

class _ManagementFinanceScreenState extends State<ManagementFinanceScreen> {
  // Mock data
  final List<Invoice> _invoices = [
    Invoice(id: 'inv002', title: 'Tiền điện T10/2025 - P.101', amount: 350000, dueDate: DateTime(2025, 11, 5), status: InvoiceStatus.Unpaid),
    Invoice(id: 'inv004', title: 'Tiền phòng T09/2025 - P.102', amount: 2500000, dueDate: DateTime(2025, 9, 5), status: InvoiceStatus.Overdue),
    Invoice(id: 'inv001', title: 'Tiền phòng T10/2025 - P.101', amount: 2500000, dueDate: DateTime(2025, 10, 5), status: InvoiceStatus.Paid),
  ];

  void _confirmPayment(Invoice invoice) {
     setState(() {
      final index = _invoices.indexWhere((inv) => inv.id == invoice.id);
      if (index != -1) {
        _invoices[index] = invoice.copyWith(status: InvoiceStatus.Paid);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xác nhận thanh toán.'), backgroundColor: Colors.green),
    );
  }

  void _createBatchInvoices() {
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã tạo hóa đơn hàng loạt thành công!'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Tài chính'),
      ),
      drawer: const ManagementDrawer(),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(invoice.title),
              subtitle: Text('Số tiền: ${currencyFormat.format(invoice.amount)}'),
              trailing: invoice.status == InvoiceStatus.Unpaid
                  ? ElevatedButton(
                      onPressed: () => _confirmPayment(invoice),
                      child: const Text('Xác nhận'),
                    )
                  : Chip(
                      label: Text(
                        invoice.status == InvoiceStatus.Paid ? 'Đã trả' : 'Quá hạn',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: invoice.status == InvoiceStatus.Paid ? Colors.green : Colors.red,
                    ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createBatchInvoices,
        label: const Text('Tạo hóa đơn hàng loạt'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
