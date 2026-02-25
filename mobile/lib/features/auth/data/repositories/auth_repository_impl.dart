import 'package:staff_health_mobile/features/auth/data/repositories/auth_remote_data_source.dart';
import 'package:staff_health_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> login(String username, String password) async {
    final data = await remoteDataSource.login(username, password);
    return data['token'];
  }
}
