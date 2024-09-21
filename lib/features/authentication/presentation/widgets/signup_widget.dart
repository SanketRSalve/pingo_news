import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      textController: _nameController,
                      hintText: "Name",
                    ),
                    const SizedBox(height: 22),
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
                      context.read<AuthProvider>().registerUser(
                          _emailController.text, _passwordController.text);
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        debugPrint("Go To Login Page");
                        context.go('/');
                      },
                      child: const Text(
                        "Login",
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
    );
  }
}
