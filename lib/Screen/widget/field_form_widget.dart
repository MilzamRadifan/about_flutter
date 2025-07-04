// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FieldFormWidget extends StatelessWidget {
  String title = '';
  bool isPassword = false;
  TextEditingController? controller;
  String? Function(String?)? validator;
  FieldFormWidget({
    super.key,
    required this.title,
    required this.isPassword,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(title),
          const SizedBox(height: 8),

          // field 
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            validator: validator,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey),
              errorStyle: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
