import 'package:dartz/dartz.dart';
import 'package:newtest/core/errors/customexiption.dart';
import 'package:newtest/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<customException, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<customException, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  });
}
