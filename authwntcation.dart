import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthenticationService {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();
}