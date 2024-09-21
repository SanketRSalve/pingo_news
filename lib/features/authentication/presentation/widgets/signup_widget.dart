
import 'package:flutter/material.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/widgets/custom_text_form_field.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      textController: _nameController,
                      hintText: "Name",
                    ),
                    const SizedBox(
                        height: 22),
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