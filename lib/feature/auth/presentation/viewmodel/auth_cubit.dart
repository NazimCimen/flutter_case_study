import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/auth/domain/usecase/login_usecase.dart';
import 'package:case_study/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_state.dart';
import 'package:case_study/core/state/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final UserCubit userCubit;

  AuthCubit({
    required this.loginUseCase, 
    required this.signupUseCase,
    required this.userCubit,
  }) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading(true));
    final result = await loginUseCase.call(email: email, password: password);
    result.fold((failure) => emit(AuthError(failure)), (user) {
      if (user != null) {
        userCubit.setUser(user); 
        emit(AuthSuccess(user));
      } else {
        emit(AuthError(UnKnownFaliure(errorMessage: 'User not found')));
      }
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading(true));
    final result = await signupUseCase.call(
      email: email,
      password: password,
      name: name,
    );

    result.fold((failure) => emit(AuthError(failure)), (user) {
      if (user != null) {
        userCubit.setUser(user); // UserCubit'e set et
        emit(AuthSuccess(user));
      } else {
        emit(AuthError(UnKnownFaliure(errorMessage: 'User not found')));
      }
    });
  }

  Future<void> logout() async {
    userCubit.clearUser(); // UserCubit'ten temizle
    emit(AuthInitial());
  }
}
