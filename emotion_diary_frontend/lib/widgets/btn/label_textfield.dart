import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final double height;
  final TextInputType keyboardType;

  const LabelTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.isObscure,
    required this.height,
    required this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333)),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }
}
