import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employees_cubit.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<EmployeesCubit>().fetchEmployees(isRefresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<EmployeesCubit>().fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الموظفون'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<EmployeesCubit, EmployeesState>(
          builder: (context, state) {
            if (state is EmployeesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خطأ: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<EmployeesCubit>().fetchEmployees(isRefresh: true),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            } else if (state is EmployeesLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<EmployeesCubit>().fetchEmployees(isRefresh: true),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.employees.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.employees.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    
                    final employee = state.employees[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(employee.fullName),
                        subtitle: Text('${employee.jobTitle} - ${employee.specialization}'),
                        trailing: Text(employee.currentStatus),
                        onTap: () {
                          // TODO: Navigate to details
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: Text('ابدأ بجلب الموظفين'));
          },
        ),
      ),
    );
  }
}
