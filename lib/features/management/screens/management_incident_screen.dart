import 'package:flutter/material.dart';
import '../../../core/models/incident_model.dart';
import '../widgets/management_drawer.dart';

class ManagementIncidentScreen extends StatefulWidget {
  const ManagementIncidentScreen({super.key});

  @override
  _ManagementIncidentScreenState createState() => _ManagementIncidentScreenState();
}

class _ManagementIncidentScreenState extends State<ManagementIncidentScreen> {
  // Mock data
  final List<IncidentModel> _incidents = [
    IncidentModel(id: 'inc002', type: IncidentType.Water, description: 'Vòi nước bị rò rỉ.', reportedDate: DateTime(2025, 10, 30), status: IncidentStatus.Submitted, room: 'P.101'),
    IncidentModel(id: 'inc003', type: IncidentType.Electricity, description: 'Cầu dao tổng bị nhảy.', reportedDate: DateTime(2025, 10, 29), status: IncidentStatus.InProgress, room: 'P.203'),
  ];

  void _updateStatus(IncidentModel incident, IncidentStatus newStatus) {
    setState(() {
      final index = _incidents.indexWhere((i) => i.id == incident.id);
      if (index != -1) {
        _incidents[index] = incident.copyWith(status: newStatus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Sự cố'),
      ),
      drawer: const ManagementDrawer(),
      body: ListView.builder(
        itemCount: _incidents.length,
        itemBuilder: (context, index) {
          final incident = _incidents[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text('${_getIncidentTypeText(incident.type)} - Phòng ${incident.room}'),
              subtitle: Text(incident.description, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: PopupMenuButton<IncidentStatus>(
                onSelected: (IncidentStatus status) {
                  _updateStatus(incident, status);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<IncidentStatus>>[
                  const PopupMenuItem<IncidentStatus>(
                    value: IncidentStatus.InProgress,
                    child: Text('Đang xử lý'),
                  ),
                  const PopupMenuItem<IncidentStatus>(
                    value: IncidentStatus.Completed,
                    child: Text('Hoàn thành'),
                  ),
                ],
                child: Chip(
                  label: Text(_getStatusText(incident.status), style: const TextStyle(color: Colors.white)),
                  backgroundColor: _getStatusColor(incident.status),
                ),
              ),
            ),
          );
        },
      ),
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
      case IncidentStatus.Submitted: return 'Mới';
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
