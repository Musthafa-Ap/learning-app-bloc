import 'package:flutter/material.dart';
import 'package:learning_app_bloc/utils/constants.dart';
import 'package:learning_app_bloc/view/auth_screens/login_page.dart';

import '../common_widgets/custom__textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool invisible = true;
  bool invisible2 = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(logo),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Name',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }

                      RegExp regex = RegExp(r'^[a-zA-Z\s]+$');

                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid name ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    errorText: null,
                    keyboardType: TextInputType.number,
                    prefix: const Text(
                      '  🇦🇪 +971 ',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    controller: phoneController,
                    maxLength: 10,
                    hintText: 'Phone number',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the phone number';
                      }
                      RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                      if (!regex.hasMatch(phoneController.text)) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    errorText: null,
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
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
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
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child:
                            //  provider.isLoading
                            //     ? Padding(
                            //         padding: const EdgeInsets.all(8),
                            //         child: CircularProgressIndicator(
                            //           color: ColorConstants.primary_white,
                            //         ),
                            //       )
                            //     :
                            Text(
                          'Register',
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
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already registered? ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
