import 'package:firebase_auth/firebase_auth.dart';
import 'package:newtest/core/errors/customexiption.dart';
import 'package:newtest/core/services/authwntcation.dart';

class FirebaseAuthService implements AuthenticationService {
  FirebaseAuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (error) {
      throw customException(message: _messageFor(error));
    }
  }

  @override
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
        );
      final user = credential.user;
      if (user == null) {
        return null;
      }

      final displayName = name.trim();
      if (displayName.isNotEmpty) {
        await user.updateDisplayName(displayName);
      }
      return _firebaseAuth.currentUser ?? user;
    } on FirebaseAuthException catch (error) {
      throw customException(message: _messageFor(error));
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  String _messageFor(FirebaseAuthException error) {
    final summary = switch (error.code) {
      'invalid-email' => 'Please enter a valid email address.',
      'user-not-found' => 'The email incorrect.',
      'wrong-password' => 'The  password is incorrect.',
      _ => 'Firebase authentication failed.',
    };
    return summary;
  }
}

