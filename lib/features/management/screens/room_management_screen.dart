import 'package:flutter/material.dart';

class RoomManagementScreen extends StatelessWidget {
  const RoomManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for rooms
    final List<Map<String, dynamic>> rooms = List.generate(20, (index) {
      final roomNumber = 101 + index;
      final status = index % 4 == 0 ? 'Trống' : (index % 4 == 1 ? 'Đang sửa' : 'Đã đủ');
      final color = status == 'Trống' ? Colors.green : (status == 'Đang sửa' ? Colors.orange : Colors.red);
      return {'number': 'P.$roomNumber', 'status': status, 'color': color, 'occupants': status == 'Đã đủ' ? 4 : 0};
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý phòng'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            elevation: 4,
            color: room['color'].withOpacity(0.8),
            child: InkWell(
              onTap: () {
                // TODO: Show room details dialog
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      room['number'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      room['status'],
                      style: const TextStyle(color: Colors.white),
                    ),
                     if(room['status'] == 'Đã đủ')
                      Text(
                        '${room['occupants']}/4',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

