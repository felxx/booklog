class UserDTO {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String role;

  UserDTO({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      id: map['id'] as int?,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  UserDTO copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? role,
  }) {
    return UserDTO(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}