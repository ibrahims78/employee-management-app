import '../../domain/repositories/employees_repository.dart';
import '../models/employee_model.dart';
import 'employees_remote_data_source.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  final EmployeesRemoteDataSource remoteDataSource;

  EmployeesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<EmployeeModel>> getEmployees({required int page, required int limit, String? search}) {
    return remoteDataSource.getEmployees(page: page, limit: limit, search: search);
  }
}
