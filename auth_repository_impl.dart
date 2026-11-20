import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtest/core/errors/customexiption.dart';
import 'package:newtest/core/services/authwntcation.dart';
import 'package:newtest/features/auth/data/models/user_model.dart';
import 'package:newtest/features/auth/domain/entities/user_entity.dart';
import 'package:newtest/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authService, required this.firestore});

  final AuthenticationService authService;
  final FirebaseFirestore firestore;

  static const _usersCollection = 'users';

  @override
  Future<Either<customException, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (firebaseUser == null) {
        return Left(
          customException(message: 'Authentication returned no user.'),
        );
      }

      final userDocument = await firestore
          .collection(_usersCollection)
          .doc(firebaseUser.uid)
          .get();
      if (!userDocument.exists) {
        return Left(
          customException(
            message:
                'No user profile was found for this account '
                '(uid: ${firebaseUser.uid}).',
          ),
        );
      }

      final data = userDocument.data();
      if (data == null) {
        return Left(
          customException(
            message: 'The user profile is empty (uid: ${firebaseUser.uid}).',
          ),
        );
      }

      return Right(
        UserModel.fromJson(id: userDocument.id, json: data).toEntity(),
      );
    } on customException catch (error) {
      return Left(error);
    } on FirebaseException catch (error) {
      return Left(_firestoreFailure(error, 'load'));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<customException, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final firebaseUser = await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      if (firebaseUser == null) {
        return Left(
          customException(message: 'Authentication returned no user.'),
        );
      }

      final user = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? email.trim(),
        name: name.trim(),
      );
      await firestore
          .collection(_usersCollection)
          .doc(user.id)
          .set(user.toJson());

      return Right(user.toEntity());
    } on customException catch (error) {
      return Left(error);
    } on FirebaseException catch (error) {
      return Left(_firestoreFailure(error, 'save'));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  customException _firestoreFailure(FirebaseException error, String action) {
    return customException(
      message:
          'Could not $action the user profile '
          '(Firestore error ${error.code}): '
          '${error.message ?? 'No additional details.'}',
    );
  }

  customException _unexpectedFailure(Object error) {
    return customException(
      message: 'Unexpected authentication error (${error.runtimeType}): $error',
    );
  }
}
