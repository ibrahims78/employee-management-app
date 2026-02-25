import 'package:staff_health_mobile/core/api/api_client.dart';
import 'package:flutter/foundation.dart';

abstract class DashboardRemoteDataSource {
  Future<Map<String, dynamic>> getStats();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Map<String, dynamic>> getStats() async {
    debugPrint('--- DASHBOARD API REQUEST ---');
    final response = await apiClient.dio.get('/stats');
    debugPrint('Dashboard stats received: ${response.data}');
    return response.data as Map<String, dynamic>;
  }
}
