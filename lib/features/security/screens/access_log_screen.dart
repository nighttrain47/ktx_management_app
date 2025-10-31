import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccessLogScreen extends StatefulWidget {
  const AccessLogScreen({super.key});

  @override
  _AccessLogScreenState createState() => _AccessLogScreenState();
}

class _AccessLogScreenState extends State<AccessLogScreen> {
  // Mock data
  final List<Map<String, dynamic>> _logs = [
    {'name': 'Nguyễn Văn A', 'mssv': 'sv01', 'time': DateTime.now().subtract(const Duration(minutes: 5)), 'type': 'Vào'},
    {'name': 'Phạm Thị B', 'mssv': 'sv02', 'time': DateTime.now().subtract(const Duration(minutes: 10)), 'type': 'Ra'},
    {'name': 'Trần Văn C', 'mssv': 'sv03', 'time': DateTime.now().subtract(const Duration(hours: 1)), 'type': 'Vào'},
  ];

  List<Map<String, dynamic>> _filteredLogs = [];

  @override
  void initState() {
    super.initState();
    _filteredLogs = _logs;
  }

  void _filterLogs(String query) {
    setState(() {
      _filteredLogs = _logs.where((log) {
        return log['name'].toLowerCase().contains(query.toLowerCase()) ||
               log['mssv'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhật ký ra/vào'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterLogs,
              decoration: const InputDecoration(
                labelText: 'Tìm kiếm theo tên hoặc MSSV',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLogs.length,
              itemBuilder: (context, index) {
                final log = _filteredLogs[index];
                final isCheckIn = log['type'] == 'Vào';
                return ListTile(
                  leading: Icon(
                    isCheckIn ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isCheckIn ? Colors.green : Colors.red,
                  ),
                  title: Text('${log['name']} (${log['mssv']})'),
                  subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(log['time'])),
                  trailing: Text(log['type'], style: TextStyle(color: isCheckIn ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

