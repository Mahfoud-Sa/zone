import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String image = "assets/image/1.jpg";

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  static String toJsonString(UserModel user) {
    return jsonEncode(<String, dynamic>{
      'id': user.id,
      'name': user.name,
      'email': user.email,
    });
  }

  static UserModel fromStringJson(String user) {
    final map = jsonDecode(user);
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  static UserModel fromApiJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}
