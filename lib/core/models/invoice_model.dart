enum InvoiceStatus { Unpaid, Paid, Overdue }

class Invoice {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final InvoiceStatus status;
  final String? description; // e.g., "Electricity bill for T10/2025"
  final Map<String, dynamic>? details; // e.g., {'old_reading': 100, 'new_reading': 250, 'rate': 3500}

  Invoice({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    this.status = InvoiceStatus.Unpaid,
    this.description,
    this.details,
  });

  Invoice copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? dueDate,
    InvoiceStatus? status,
    String? description,
    Map<String, dynamic>? details,
  }) {
    return Invoice(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      description: description ?? this.description,
      details: details ?? this.details,
    );
  }
}
