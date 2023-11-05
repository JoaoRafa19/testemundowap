import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/theme/core.theme.colors.dart';

class FormImput extends StatelessWidget {
  const FormImput(
      {super.key,
      this.inputName,
      this.controller,
      this.obscuredText = false,
      this.validator});
  final String? inputName;
  final TextEditingController? controller;
  final bool obscuredText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscuredText,
        decoration: InputDecoration(
          focusColor: AppColors.bodyBlack,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          fillColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.lightGrey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.redAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.lightGrey,
              width: 2.0,
            ),
          ),
          labelText: inputName?.toLowerCase().capitalizeFirst,
        ),
      ),
    );
  }
}
