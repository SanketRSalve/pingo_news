import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/core/utils/form_validators.dart';
import 'package:lingo_news/core/widgets/custom_text_form_field.dart';
import 'package:lingo_news/features/authentication/controller/authentication_controller.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "MyNews" at the top left
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "MyNews",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.primaryBlue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(flex: 2),
              Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        textController: _emailController,
                        hintText: "Email",
                        validator: FormValidators.validateEmail,
                      ),
                      const SizedBox(height: 22),
                      CustomTextFormField(
                        textController: _passwordController,
                        hintText: "Password",
                        validator: FormValidators.validatePassword,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 3),

              Column(
                children: [
                  Consumer<AuthenticationController>(
                      builder: (context, authProvider, child) {
                    return authProvider.state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : PrimaryButton(
                            label: "Login",
                            onPressed: authProvider.state.isLoading
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      await context
                                          .read<AuthenticationController>()
                                          .loginWithEmailAndPassword(
                                              _emailController.text,
                                              _passwordController.text);
                                    }
                                  });
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New Here?"),
                      TextButton(
                        onPressed: () {
                          debugPrint("Go To Signup Page");
                          context.go('/register');
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
