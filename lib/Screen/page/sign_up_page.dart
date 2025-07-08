import 'package:event_management_app/Screen/widget/button_widget.dart';
import 'package:event_management_app/Screen/widget/field_form_widget.dart';
import 'package:event_management_app/Service/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override 
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // title
              const SizedBox(height: 20),
              const Text(
                "Wellcome",
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
        
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
        
                    // confirm password
                    FieldFormWidget(
                      title: "Confirm Password",
                      isPassword: true,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        }
        
                        if (value.length < 8) {
                          return 'Password minimal 6 karakter';
                        }
        
                        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                          return 'Password harus mengandung huruf besar, huruf kecil, dan angka';
                        }
        
                        if (value != passwordController.text) {
                          return 'Password tidak sama';
                        }
        
                        return null;
                      },
                    ),
        
                    const SizedBox(height: 20),
                    
                    //bt register
                    ButtonWidget(
                      title: "Register",
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          await Authservice().signUp(
                            email: emailController.text,
                            password: passwordController.text, 
                            context: context,
                          );
                        }
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signin');
                          },
                          child: const Text("Sign In"),
                        ),
                      ],
                    ),
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
