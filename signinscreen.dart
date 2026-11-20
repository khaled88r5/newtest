import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtest/core/WIDGETS/button.dart';
import 'package:newtest/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:newtest/features/auth/presentation/cubit/auth_state.dart';
import 'package:newtest/features/auth/signup/resetpass.dart';
import 'package:newtest/features/auth/signup/signup.dart';
import 'package:newtest/features/auth/signup/widget/customfield.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    context.read<AuthCubit>().signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (kDebugMode && state is AuthSuccess) {
          final user = state.user;
          debugPrint(
            'Signed in user: uid=${user.id}, name=${user.name}, '
            'email=${user.email}',
          );
        }

        final message = switch (state) {
          AuthSuccess() => 'تم تسجيل الدخول بنجاح',
          AuthFailure(:final message) => message,
          _ => null,
        };
        if (message != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
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
            title: const Center(child: Text('تسجيل دخول')),
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
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const resetpass(),
                          ),
                        );
                      },
                      child: const Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 27, 94, 55),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading ? null : _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 27, 94, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(340, 50),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'لا تمتلك حساب ؟',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 148, 157, 158),
                            ),
                          ),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ),
                                    );
                                  },
                            child: const Text(
                              ' قم بانشاء حساب',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 27, 94, 55),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color.fromARGB(255, 21, 196, 196),
                            thickness: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'او تسجيل الدخول باستخدام',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 148, 157, 158),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color.fromARGB(255, 21, 196, 196),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Custombutton(
                      txt: Text('Login'),
                      icon: Icon(Icons.login),
                      fillColor: Color.fromRGBO(27, 94, 55, 1),
                    ),
                    const SizedBox(height: 20),
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
