import 'package:flutter/material.dart';

class AccessHistoryScreen extends StatelessWidget {
  const AccessHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử ra/vào'),
      ),
      body: const Center(
        child: Text('Nội dung màn hình lịch sử ra/vào'),
      ),
    );
  }
}
