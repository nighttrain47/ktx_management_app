import 'dart:async';

import '../models/user_model.dart';

/// A simple mock authentication service used by the app while there's no
/// backend connected. It provides the methods used across the project:
/// - `login(username, password)` returns a `UserRole?` on success
/// - `logout()` completes immediately
/// - `checkLoginStatus()` returns the currently "logged in" user's role
///
/// This is intentionally lightweight and synchronous-friendly so the app can
/// run in development without additional dependencies.
class AuthService {
  // In-memory "current user" for the mock service.
  UserRole? _currentRole;

  /// Simulate logging in. For quick testing the project uses these test
  /// accounts (see other files using these values):
  /// - student@ / password => student
  /// - management@ / password => management
  /// - security@  / password => security
  UserRole? login(String username, String password) {
    // Return immediately (no artificial delay) to avoid creating timers that
    // can interfere with tests.
    if (password != 'password') return null;

    switch (username) {
      case 'student@':
        _currentRole = UserRole.student;
        break;
      case 'management@':
        _currentRole = UserRole.management;
        break;
      case 'security@':
        _currentRole = UserRole.security;
        break;
      default:
        return null;
    }

    return _currentRole;
  }

  /// Simulate logout by clearing the in-memory user
  Future<void> logout() async {
    _currentRole = null;
    return;
  }

  /// Return the role of the currently logged in user, or `UserRole.unknown`
  /// if no user is logged in. The method mirrors the async behaviour expected
  /// by callers.
  Future<UserRole> checkLoginStatus() async {
    return _currentRole ?? UserRole.unknown;
  }
}
