import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtest/core/WIDGETS/button.dart';
import 'package:newtest/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:newtest/features/auth/presentation/cubit/auth_state.dart';
import 'package:newtest/features/auth/signup/widget/customfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      _showMessage('يرجى إدخال الاسم والبريد الإلكتروني وكلمة المرور');
      return;
    }
    if (!_acceptedTerms) {
      _showMessage('يرجى الموافقة على الشروط والأحكام');
      return;
    }

    context.read<AuthCubit>().signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        final message = switch (state) {
          AuthSuccess() => 'تم إنشاء الحساب بنجاح',
          AuthFailure(:final message) => message,
          _ => null,
        };
        if (message != null) {
          _showMessage(message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: const Center(child: Text('انشاء حساب')),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Customtextfiel(
                      controller: _nameController,
                      hintText: 'الاسم',
                      fillColor: const Color.fromRGBO(249, 250, 250, 1),
                    ),
                    const SizedBox(height: 20),
                    Customtextfiel(
                      controller: _emailController,
                      hintText: 'البريد الالكتروني',
                      fillColor: const Color.fromRGBO(249, 250, 250, 1),
                    ),
                    const SizedBox(height: 20),
                    Customtextfiel(
                      controller: _passwordController,
                      hintText: 'كلمة المرور',
                      fillColor: const Color.fromRGBO(249, 250, 250, 1),
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'الموافقة على الشروط والأحكام',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 148, 157, 158),
                          ),
                        ),
                        Checkbox(
                          value: _acceptedTerms,
                          onChanged: isLoading
                              ? null
                              : (value) => setState(
                                  () => _acceptedTerms = value ?? false,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Custombutton(
                        txt: const Text('انشاء حساب جديد'),
                        icon: const Icon(Icons.person_add_alt_1_outlined),
                        fillColor: const Color.fromRGBO(27, 94, 55, 1),
                        onPressed: isLoading ? null : _signUp,
                        isLoading: isLoading,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 27, 94, 55),
                            ),
                          ),
                        ),
                        const Text(
                          'هل لديك حساب ؟',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 148, 157, 158),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
