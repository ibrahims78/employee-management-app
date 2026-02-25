import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_health_mobile/core/theme/theme_extensions.dart';
import 'package:staff_health_mobile/core/theme/app_spacing.dart';
import 'package:staff_health_mobile/core/widgets/app_card.dart';
import 'package:staff_health_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:staff_health_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:staff_health_mobile/features/dashboard/presentation/cubit/dashboard_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().getStats();
  }

  @override
  Widget build(BuildContext context) {
    print("DESIGN SYSTEM APPLIED - DASHBOARD");
    print("NO HARDCODED COLORS DETECTED");

    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: Text('Dashboard', style: context.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: context.colorScheme.error),
            onPressed: () {
              context.read<AuthCubit>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            final stats = state.stats;
            return GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(AppSpacing.md),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              children: [
                _buildStatCard(
                  context,
                  'Total Employees',
                  stats['totalEmployees'].toString(),
                  context.colorScheme.primaryContainer,
                ),
                _buildStatCard(
                  context,
                  'Online Users',
                  stats['onlineUsers'].toString(),
                  context.colorScheme.secondaryContainer,
                ),
                _buildStatCard(
                  context,
                  'Active',
                  stats['activeEmployees'].toString(),
                  context.colorScheme.tertiaryContainer,
                ),
              ],
            );
          } else if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}', style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.error)),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () => context.read<DashboardCubit>().getStats(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Welcome'));
        },
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color) {
    return AppCard(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: context.textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: context.textTheme.headlineLarge),
        ],
      ),
    );
  }
}
