import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtest/core/errors/customexiption.dart';
import 'package:newtest/features/auth/domain/entities/user_entity.dart';
import 'package:newtest/features/auth/domain/repositories/auth_repository.dart';
import 'package:newtest/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthInitial());

  final AuthRepository _authRepository;

  Future<void> signIn({required String email, required String password}) {
    return _authenticate(
      () => _authRepository.signIn(email: email, password: password),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) {
    return _authenticate(
      () =>
          _authRepository.signUp(email: email, password: password, name: name),
    );
  }

  Future<void> _authenticate(
    Future<Either<customException, UserEntity>> Function() request,
  ) async {
    emit(const AuthLoading());
    try {
      final result = await request();
      result.fold(
        (failure) => emit(AuthFailure(failure.getMessage())),
        (user) => emit(AuthSuccess(user)),
      );
    } catch (error) {
      final message = error is customException
          ? error.getMessage()
          : 'Authentication failed (${error.runtimeType}): $error';
      emit(AuthFailure(message));
    }
  }
}
