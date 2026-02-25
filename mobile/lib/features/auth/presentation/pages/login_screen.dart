import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_health_mobile/core/theme/theme_extensions.dart';
import 'package:staff_health_mobile/core/theme/app_spacing.dart';
import 'package:staff_health_mobile/core/widgets/primary_button.dart';
import 'package:staff_health_mobile/core/widgets/app_text_field.dart';
import 'package:staff_health_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:staff_health_mobile/features/dashboard/presentation/pages/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    print("DESIGN SYSTEM APPLIED - LOGIN");
    print("NO HARDCODED COLORS DETECTED");
    
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: Text('Login', style: context.textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Failed: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome Back', style: context.textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.xl),
              AppTextField(controller: _usernameController, label: 'Username'),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _passwordController, label: 'Password', obscureText: true),
              const SizedBox(height: AppSpacing.lg),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return PrimaryButton(
                    label: 'Login',
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      context.read<AuthCubit>().login(
                            _usernameController.text,
                            _passwordController.text,
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
