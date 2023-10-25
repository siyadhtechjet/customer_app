import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.content,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String content;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: content,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
