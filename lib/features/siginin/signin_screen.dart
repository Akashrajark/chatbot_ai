import 'package:chatbot_ai/common_widgets.dart/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../../common_widgets.dart/custom_text_formfield.dart';
import '../../common_widgets.dart/forgot_password.dart';
import '../../common_widgets.dart/text_link.dart';
import '../home_screen.dart';
import '../../util/value_validator.dart';
import '../sign_up/sign_up.dart';
import 'signin_bloc/signin_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => SigninBloc(),
          child: BlocConsumer<SigninBloc, SigninState>(
            listener: (context, state) {
              if (state is SigninSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              } else if (state is SigninFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failed',
                    description: state.message,
                    primaryButton: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Text(
                          'Signin',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        isLoading: state is SigninLoadingState,
                        controller: _emailController,
                        validator: emailValidator,
                        labelText: 'email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        validator: passwordValidator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          hintText: 'password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _obscureText = !_obscureText;
                              setState(() {});
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextLink(
                          text: 'Forgot Password?',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => const ForgotPasswordDialog(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GradientButton(
                        isLoading: state is SigninLoadingState,
                        text: 'Sign In',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<SigninBloc>(context).add(
                              SigninEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dont have an account?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
