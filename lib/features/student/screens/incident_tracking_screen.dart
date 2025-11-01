import 'package:flutter/material.dart';

class IncidentTrackingScreen extends StatelessWidget {
  const IncidentTrackingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theo dõi sự cố'),
      ),
      body: const Center(
        child: Text('Nội dung màn hình theo dõi sự cố'),
      ),
    );
  }
}
