import '../repositories/employees_repository.dart';
import '../../data/models/employee_model.dart';

class GetEmployeesUseCase {
  final EmployeesRepository repository;

  GetEmployeesUseCase(this.repository);

  Future<List<EmployeeModel>> call({required int page, required int limit, String? search}) {
    return repository.getEmployees(page: page, limit: limit, search: search);
  }
}
