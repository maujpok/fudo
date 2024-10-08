import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo/app/extensions.dart';
import 'package:fudo/app/routes.dart';
import 'package:fudo/app/static_data.dart';
import 'package:fudo/app/ui_style.dart';
import 'package:fudo/presentation/utils/toast_handler.dart';
import 'package:fudo/presentation/utils/validations.dart';
import 'package:fudo/presentation/views/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticatedSuccess) {
          ToastHandler.showSuccessToast('Login Successful');
          _emailController.clear();
          _passwordController.clear();
          context.pushReplacementNamed(RoutePath.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Fudo Challenge!',
                style: TextStyle(fontSize: AppSizes.textBig),
              ),
              const SizedBox(height: AppSizes.paddingMax),
              SizedBox(
                width: 160,
                height: 160,
                child: ClipOval(
                  child: Image.asset(fudoImagePath),
                ),
              ),
              const SizedBox(height: AppSizes.paddingMax),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: AppColors.defaultTextColor),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          alignLabelWithHint: true,
                        ),
                        validator: (emailInput) {
                          if (emailInput == null || emailInput.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!isValidEmail(emailInput)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: AppColors.defaultTextColor),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                        ),
                        validator: (passwordInput) {
                          if (passwordInput == null || passwordInput.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSizes.paddingMax),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          } else {
                            ToastHandler.showErrorToast('Check your credentials please');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: const Color(0XFFFF5023),
                          foregroundColor: Colors.white,
                        ),
                        child: state.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1.2,
                              )
                            : const Text('Log In'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
