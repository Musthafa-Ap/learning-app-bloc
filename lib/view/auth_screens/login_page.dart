import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:learning_app_bloc/blocs/auth_bloc/auth_event.dart';
import 'package:learning_app_bloc/blocs/auth_bloc/auth_state.dart';
import 'package:learning_app_bloc/view/auth_screens/register_screen.dart';
import 'package:learning_app_bloc/view/common_widgets/general_functions.dart';
import 'package:learning_app_bloc/view/home_screen/home_screen.dart';

import '../../utils/constants.dart';
import '../common_widgets/custom__textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool invisible = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // if (kDebugMode) {
    //   emailController.text = 'jithu@gmail.com';
    //   passwordController.text = 'Jithu@123';
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
              key: _formKey,
              child: BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(logo),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextField(
                        errorText:
                            state is AuthErrorState ? state.emailError : null,
                        maxLines: 1,
                        controller: emailController,
                        hintText: 'Email address',
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email address';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }

                          return null;
                        },
                        onChanged: (p0) => authBloc.add(EmailReEnteredEvent(
                            passwordError: state is AuthErrorState
                                ? state.passwordError
                                : null)),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        errorText: state is AuthErrorState
                            ? state.passwordError
                            : null,
                        controller: passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter';
                          }

                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          final RegExp regSpecial = RegExp(r'[!@#\$&*~]');
                          if (!regSpecial.hasMatch(value)) {
                            return 'Password must contain at least one special charater';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          return null;
                        },
                        onChanged: (p0) => authBloc.add(PasswordReEnteredEvent(
                            emailError: state is AuthErrorState
                                ? state.emailError
                                : null)),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            authBloc.add(LoginButtonPressedEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: state is AuthLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  } else if (state is AuthFailureState) {
                    log("message");
                    showSnackBarMessage(
                        context: context, msg: 'Login failure . Try again !!');
                  }
                },
              )),
        ),
      ),
    );
  }
}
