import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/incident_model.dart';

class IncidentDetailScreen extends StatelessWidget {
  final IncidentModel incident;

  const IncidentDetailScreen({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sự cố'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildInfoCard(),
            const SizedBox(height: 24),
            _buildProgressTracker(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            _getIncidentTypeText(incident.type),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Chip(
          label: Text(
            _getStatusText(incident.status),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(incident.status),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Ngày báo cáo:', DateFormat('dd/MM/yyyy HH:mm').format(incident.reportedDate)),
            const SizedBox(height: 16),
            const Text('Mô tả:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(incident.description, style: const TextStyle(height: 1.5)),
            // Placeholder for image display
            // if (incident.imageUrl != null) ...[
            //   const SizedBox(height: 16),
            //   const Text('Hình ảnh đính kèm:', style: TextStyle(fontWeight: FontWeight.bold)),
            //   const SizedBox(height: 8),
            //   Center(child: Image.asset('assets/mock_image.png')), // Example with a mock asset
            // ]
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTracker(BuildContext context) {
    // Mock progress data based on incident status
    final List<Map<String, dynamic>> progressSteps = [
      {'status': IncidentStatus.Submitted, 'date': incident.reportedDate, 'note': 'Sinh viên đã gửi báo cáo.'},
      if (incident.status == IncidentStatus.InProgress || incident.status == IncidentStatus.Completed)
        {'status': IncidentStatus.InProgress, 'date': incident.reportedDate.add(const Duration(hours: 2)), 'note': 'BQL đã tiếp nhận và đang phân công nhân viên xử lý.'},
      if (incident.status == IncidentStatus.Completed)
        {'status': IncidentStatus.Completed, 'date': incident.reportedDate.add(const Duration(days: 1)), 'note': 'Sự cố đã được khắc phục xong.'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lịch sử xử lý', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        ...progressSteps.reversed.map((step) {
          final isLast = progressSteps.reversed.first == step;
          return _buildProgressStep(step['status'], step['date'], step['note'], isLast);
        }).toList(),
      ],
    );
  }

  Widget _buildProgressStep(IncidentStatus status, DateTime date, String note, bool isLastStep) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.check_circle, color: _getStatusColor(status)),
            if (!isLastStep)
              Container(
                width: 2,
                height: 60,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getStatusText(status),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(date),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(note),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  String _getIncidentTypeText(IncidentType type) {
    switch (type) {
      case IncidentType.Electricity: return 'Sự cố Điện';
      case IncidentType.Water: return 'Sự cố Nước';
      case IncidentType.Internet: return 'Sự cố Mạng';
      case IncidentType.Furniture: return 'Sự cố Nội thất';
      case IncidentType.Other: return 'Khác';
    }
  }

  String _getStatusText(IncidentStatus status) {
    switch (status) {
      case IncidentStatus.Submitted: return 'Đã gửi';
      case IncidentStatus.InProgress: return 'Đang xử lý';
      case IncidentStatus.Completed: return 'Hoàn thành';
    }
  }

  Color _getStatusColor(IncidentStatus status) {
    switch (status) {
      case IncidentStatus.Submitted: return Colors.blue;
      case IncidentStatus.InProgress: return Colors.orange;
      case IncidentStatus.Completed: return Colors.green;
    }
  }
}
