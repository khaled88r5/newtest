import 'package:firebase_auth/firebase_auth.dart';
import 'package:newtest/features/auth/domain/entities/user_entity.dart';

class UserModel {
  const UserModel({required this.id, required this.email, required this.name});

  final String id;
  final String email;
  final String name;

  factory UserModel.fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    final storedId = json['uid'];
    if (storedId != null && storedId != id) {
      throw const FormatException('User document UID does not match its ID.');
    }

    final email = json['email'];
    final name = json['name'];
    if (email is! String || name is! String) {
      throw const FormatException(
        'User document must contain string email and name fields.',
      );
    }

    return UserModel(id: id, email: email, name: name);
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid': id, 'email': email, 'name': name};
  }

  UserEntity toEntity() {
    return UserEntity(id: id, email: email, name: name);
  }
}
