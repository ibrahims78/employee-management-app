import 'package:staff_health_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardStatsUseCase {
  final DashboardRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<Map<String, dynamic>> call() async {
    return await repository.getDashboardStats();
  }
}
