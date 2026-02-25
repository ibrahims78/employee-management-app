import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_health_mobile/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:flutter/foundation.dart';

abstract class DashboardState {}
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final Map<String, dynamic> stats;
  DashboardLoaded(this.stats);
}
class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardStatsUseCase getDashboardStatsUseCase;

  DashboardCubit(this.getDashboardStatsUseCase) : super(DashboardInitial());

  Future<void> getStats() async {
    debugPrint('--- DASHBOARD CUBIT: FETCHING STATS ---');
    emit(DashboardLoading());
    try {
      final stats = await getDashboardStatsUseCase();
      debugPrint('--- DASHBOARD CUBIT: STATS LOADED (Items: ${stats.length}) ---');
      emit(DashboardLoaded(stats));
    } catch (e) {
      debugPrint('--- DASHBOARD CUBIT: ERROR - $e ---');
      emit(DashboardError(e.toString()));
    }
  }
}
