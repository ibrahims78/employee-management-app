import 'package:staff_health_mobile/features/dashboard/data/repositories/dashboard_remote_data_source.dart';
import 'package:staff_health_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    return await remoteDataSource.getStats();
  }
}
