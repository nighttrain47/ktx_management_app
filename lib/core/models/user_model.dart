enum UserRole { student, management, security, unknown }

class UserModel {
  final String id;
  final String username;
  final String fullName;
  final UserRole role;
  final String? room;

  const UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    this.room,
  });

  // Factory constructor để tạo user từ Map (ví dụ từ API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      role: stringToRole(json['role']),
      room: json['room'],
    );
  }

  // Chuyển đổi từ string sang enum UserRole
  static UserRole stringToRole(String? role) {
    switch (role) {
      case 'student':
        return UserRole.student;
      case 'management':
        return UserRole.management;
      case 'security':
        return UserRole.security;
      default:
        return UserRole.unknown;
    }
  }

  // Chuyển đổi từ enum UserRole sang string
  String roleToString() {
    return role.toString().split('.').last;
  }
}