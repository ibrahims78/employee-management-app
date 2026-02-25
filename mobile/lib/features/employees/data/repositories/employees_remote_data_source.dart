import 'package:dio/dio.dart';
import '../models/employee_model.dart';

abstract class EmployeesRemoteDataSource {
  Future<List<EmployeeModel>> getEmployees({required int page, required int limit, String? search});
}

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  final Dio dio;

  EmployeesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<EmployeeModel>> getEmployees({required int page, required int limit, String? search}) async {
    try {
      print('--- FLUTTER REQUEST ---');
      print('Endpoint: /api/employees');
      print('Parameters: {page: $page, limit: $limit, search: $search}');
      
      final response = await dio.get(
        '/api/employees',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      print('Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final List data = response.data;
        print('Fetched ${data.length} employees');
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employees: $e');
      rethrow;
    }
  }
}
