import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_health_mobile/core/api/api_client.dart';
import 'package:staff_health_mobile/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated(this.token);
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final token = await loginUseCase(username, password);
      await apiClient.storage.write(key: 'jwt_token', value: token);
      emit(AuthAuthenticated(token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await apiClient.storage.delete(key: 'jwt_token');
    emit(AuthInitial());
  }
}
