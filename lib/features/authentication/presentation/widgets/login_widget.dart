import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/core/widgets/custom_text_form_field.dart';
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(flex: 2),
              Center(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        textController: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(height: 22),
                      CustomTextFormField(
                        textController: _passwordController,
                        hintText: "Password",
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 3),

              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.56,
                    height: 48.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                      onPressed: () {
                        debugPrint("Signup");
                        debugPrint(_emailController.text);
                        context.read<AuthProvider>().loginUser(
                            _emailController.text, _passwordController.text);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
                          style: TextStyle(color: AppColors.primaryBlue),
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
