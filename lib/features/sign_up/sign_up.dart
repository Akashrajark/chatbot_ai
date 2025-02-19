import 'package:chatbot_ai/features/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../../common_widgets.dart/custom_text_formfield.dart';
import '../../common_widgets.dart/gradient_button.dart';
import '../../util/value_validator.dart';
import '../siginin/signin_screen.dart';
import 'sign_up_bloc/sign_up_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => SignUpBloc(),
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    description: state.message,
                    primaryButton: 'Try Again',
                    onPrimaryPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else if (state is SignUpSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
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
                          'Sign Up',
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
                        isLoading: state is SignUpLoadingState,
                        labelText: 'Name',
                        controller: _nameController,
                        validator: alphabeticWithSpaceValidator,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        isLoading: state is SignUpLoadingState,
                        labelText: 'Email',
                        controller: _emailController,
                        validator: emailValidator,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: _obscureText,
                        controller: _passwordController,
                        validator: passwordValidator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) => confirmPasswordValidator(
                            value, _passwordController.text.trim()),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'confirm password',
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
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GradientButton(
                        isLoading: state is SignUpLoadingState,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<SignUpBloc>(context).add(
                              SignUpUserEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  userDetails: {
                                    'name': _nameController.text.trim(),
                                    'email': _emailController.text.trim(),
                                  }),
                            );
                          }
                        },
                        text: 'Sign Up',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SigninScreen()));
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
