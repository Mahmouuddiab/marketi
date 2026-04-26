class LoginModel {
  final String message;
  final String token;

  final String name;
  final String phone;
  final String email;
  final String role;
  final String image;

  LoginModel({
    required this.message,
    required this.token,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.image,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return LoginModel(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      name: user['name'] ?? '',
      phone: user['phone'] ?? '',
      email: user['email'] ?? '',
      role: user['role'] ?? '',
      image: user['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': {
        'name': name,
        'phone': phone,
        'email': email,
        'role': role,
        'image': image,
      },
    };
  }
}