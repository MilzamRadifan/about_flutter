import 'package:event_management_app/Screen/widget/button_widget.dart';
import 'package:event_management_app/Screen/widget/field_form_widget.dart';
import 'package:event_management_app/Service/auth_service.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // title
              const SizedBox(height: 20),
              const Text(
                "Hello Again",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // form

              Form(
                key: formKey,
                child: Column(
                  children: [
                    // email
                    FieldFormWidget(
                      title: "Email",
                      isPassword: false,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        }

                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),

                    // password
                    FieldFormWidget(
                      title: "Password",
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        }

                        if (value.length < 8) {
                          return 'Password minimal 6 karakter';
                        }

                        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)')
                            .hasMatch(value)) {
                          return 'Password harus mengandung huruf besar, huruf kecil, dan angka';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    //bt register
                    ButtonWidget(
                      title: "Sign In",
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          await Authservice().signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // google sign
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          await Authservice().googleSignIn(context: context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Image.asset(
                          'lib/core/assets/ic_google.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: const Text("Create Account"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
