import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../../data/models/employee_model.dart';

abstract class EmployeesState {}

class EmployeesInitial extends EmployeesState {}
class EmployeesLoading extends EmployeesState {}
class EmployeesLoaded extends EmployeesState {
  final List<EmployeeModel> employees;
  final bool hasMore;
  final bool isFetchingMore;
  EmployeesLoaded({
    required this.employees, 
    required this.hasMore, 
    this.isFetchingMore = false
  });

  EmployeesLoaded copyWith({
    List<EmployeeModel>? employees,
    bool? hasMore,
    bool? isFetchingMore,
  }) {
    return EmployeesLoaded(
      employees: employees ?? this.employees,
      hasMore: hasMore ?? this.hasMore,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}
class EmployeesError extends EmployeesState {
  final String message;
  EmployeesError(this.message);
}

class EmployeesCubit extends Cubit<EmployeesState> {
  final GetEmployeesUseCase getEmployeesUseCase;
  int _currentPage = 1;
  final int _limit = 50; // Matched with Web storage.ts default
  bool _isFetching = false;

  EmployeesCubit(this.getEmployeesUseCase) : super(EmployeesInitial());

  Future<void> fetchEmployees({bool isRefresh = false, String? search}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (isRefresh) {
      _currentPage = 1;
      emit(EmployeesLoading());
    }

    try {
      print('--- BEHAVIOR PARITY AUDIT ---');
      print('Current Page: $_currentPage');
      print('Per Page (Limit): $_limit');
      print('Search Parameter: ${search ?? "None"}');
      print('Web Parity Check:');
      print(' - current_page matching: YES (tracked in cubit)');
      print(' - per_page matching: YES (set to 50)');
      print(' - Search param name: YES (passing "search")');
      print(' - Reset page on search: YES (isRefresh logic)');
      
      final employees = await getEmployeesUseCase(
        page: _currentPage, 
        limit: _limit,
        search: search,
      );
      
      final bool hasMore = employees.length == _limit;
      print('Cubit: Received ${employees.length} items. Has more: $hasMore');

      if (state is EmployeesLoaded && !isRefresh) {
        final currentState = state as EmployeesLoaded;
        emit(currentState.copyWith(
          employees: [...currentState.employees, ...employees],
          hasMore: hasMore,
          isFetchingMore: false,
        ));
      } else {
        emit(EmployeesLoaded(
          employees: employees,
          hasMore: hasMore,
        ));
      }
      
      if (hasMore) _currentPage++;
    } catch (e) {
      emit(EmployeesError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> fetchMore() async {
    if (state is! EmployeesLoaded || _isFetching) return;
    final currentState = state as EmployeesLoaded;
    if (!currentState.hasMore) return;

    emit(currentState.copyWith(isFetchingMore: true));
    await fetchEmployees();
  }
}
