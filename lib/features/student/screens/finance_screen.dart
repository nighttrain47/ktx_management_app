import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/invoice_model.dart';
import 'invoice_detail_screen.dart';
import 'transaction_history_screen.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data
  final List<Invoice> _allInvoices = [
    Invoice(id: 'inv001', title: 'Tiền phòng T10/2025', amount: 2500000, dueDate: DateTime(2025, 10, 5), status: InvoiceStatus.Paid),
    Invoice(id: 'inv002', title: 'Tiền điện T10/2025', amount: 350000, dueDate: DateTime(2025, 11, 5), status: InvoiceStatus.Unpaid),
    Invoice(id: 'inv003', title: 'Tiền nước T10/2025', amount: 150000, dueDate: DateTime(2025, 11, 5), status: InvoiceStatus.Unpaid),
    Invoice(id: 'inv004', title: 'Tiền phòng T09/2025', amount: 2500000, dueDate: DateTime(2025, 9, 5), status: InvoiceStatus.Overdue),
    Invoice(id: 'inv005', title: 'Tiền mạng T09/2025', amount: 100000, dueDate: DateTime(2025, 9, 5), status: InvoiceStatus.Paid),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài chính & Thanh toán'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Lịch sử giao dịch',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionHistoryScreen()));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tất cả'),
            Tab(text: 'Chưa TT'),
            Tab(text: 'Quá hạn'),
            Tab(text: 'Đã TT'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInvoiceList(_allInvoices),
          _buildInvoiceList(_allInvoices.where((i) => i.status == InvoiceStatus.Unpaid).toList()),
          _buildInvoiceList(_allInvoices.where((i) => i.status == InvoiceStatus.Overdue).toList()),
          _buildInvoiceList(_allInvoices.where((i) => i.status == InvoiceStatus.Paid).toList()),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(List<Invoice> invoices) {
    if (invoices.isEmpty) {
      return const Center(child: Text('Không có hóa đơn nào.'));
    }
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

    return ListView.builder(
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(_getStatusIcon(invoice.status), color: _getStatusColor(invoice.status)),
            title: Text(invoice.title),
            subtitle: Text('Hạn: ${DateFormat('dd/MM/yyyy').format(invoice.dueDate)}'),
            trailing: Text(currencyFormat.format(invoice.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InvoiceDetailScreen(invoice: invoice),
                ),
              );
            },
          ),
        );
      },
    );
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

    IconData _getStatusIcon(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.Paid:
        return Icons.check_circle;
      case InvoiceStatus.Unpaid:
        return Icons.hourglass_bottom;
      case InvoiceStatus.Overdue:
        return Icons.error;
    }
  }
}
