import 'package:flutter/material.dart';
import 'package:ktx_management_app/features/student/screens/student_dashboard_screen.dart';
import 'package:ktx_management_app/features/management/screens/management_dashboard_screen.dart';
import 'package:ktx_management_app/features/security/screens/security_dashboard_screen.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final user = await _authService.login(
      _usernameController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null && mounted) {
      // Đăng nhập thành công, điều hướng dựa trên vai trò
      _navigateToDashboard(user.role);
    } else if (mounted) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tên đăng nhập hoặc mật khẩu không đúng!')),
      );
    }
  }

  void _navigateToDashboard(UserRole role) {
    Widget page;
    switch (role) {
      case UserRole.student:
        page = const StudentDashboardScreen();
        break;
      case UserRole.management:
        page = const ManagementDashboardScreen();
        break;
      case UserRole.security:
        page = const SecurityDashboardScreen();
        break;
      default:
      // Trường hợp không xác định, quay lại màn hình đăng nhập
        return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập KTX')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
              // Gợi ý tài khoản để test
              // Tạm điền sẵn để test nhanh: sv01, bql01, bv01. Mật khẩu đều là '123'
              onTap: () => _usernameController.text = 'sv01',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
              onTap: () => _passwordController.text = '123',
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _login,
              child: const Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}