import '../../data/models/employee_model.dart';

abstract class EmployeesRepository {
  Future<List<EmployeeModel>> getEmployees({required int page, required int limit, String? search});
}
