import 'package:flutter/material.dart';
import 'package:ktx_management_app/core/models/user_model.dart';
import 'package:ktx_management_app/core/services/auth_service.dart';
import 'package:ktx_management_app/features/management/screens/management_dashboard_screen.dart';
import 'package:ktx_management_app/features/security/screens/security_dashboard_screen.dart';
import 'package:ktx_management_app/features/student/screens/student_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    // For demonstration, we'll use hardcoded credentials
    // In a real app, you would call a service to authenticate.
    final role = _authService.login(_emailController.text, _passwordController.text);

    if (role != null && mounted) {
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
        case UserRole.unknown:
          // Should not happen with the current logic, but good to handle
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid credentials')),
          );
          return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email (student@, management@, security@)',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password (password)',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
