import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_health_mobile/core/api/api_client.dart';
import 'package:staff_health_mobile/features/auth/data/repositories/auth_remote_data_source.dart';
import 'package:staff_health_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:staff_health_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:staff_health_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:staff_health_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:staff_health_mobile/features/dashboard/data/repositories/dashboard_remote_data_source.dart';
import 'package:staff_health_mobile/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:staff_health_mobile/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:staff_health_mobile/features/dashboard/presentation/cubit/dashboard_cubit.dart';

import 'package:staff_health_mobile/core/theme/app_theme.dart';

void main() {
  // Simple Dependency Injection
  final authRemoteDataSource = AuthRemoteDataSourceImpl(apiClient);
  final authRepository = AuthRepositoryImpl(authRemoteDataSource);
  final loginUseCase = LoginUseCase(authRepository);
  final authCubit = AuthCubit(loginUseCase);

  final dashboardRemoteDataSource = DashboardRemoteDataSourceImpl(apiClient);
  final dashboardRepository = DashboardRepositoryImpl(dashboardRemoteDataSource);
  final getDashboardStatsUseCase = GetDashboardStatsUseCase(dashboardRepository);
  final dashboardCubit = DashboardCubit(getDashboardStatsUseCase);

  runApp(StaffHealthApp(
    authCubit: authCubit,
    dashboardCubit: dashboardCubit,
  ));
}

class StaffHealthApp extends StatelessWidget {
  final AuthCubit authCubit;
  final DashboardCubit dashboardCubit;
  
  const StaffHealthApp({
    super.key, 
    required this.authCubit,
    required this.dashboardCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authCubit),
        BlocProvider(create: (context) => dashboardCubit),
      ],
      child: MaterialApp(
        title: 'Staff Health',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const LoginScreen(),
      ),
    );
  }
}
