import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/theme/core.theme.colors.dart';

class FormInput extends StatelessWidget {
  const FormInput(
      {super.key,
      this.inputName,
      this.controller,
      this.obscuredText = false,
      this.validator,
      this.isPriceInput});
  final String? inputName;
  final TextEditingController? controller;
  final bool obscuredText;
  final bool? isPriceInput;
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
        inputFormatters: isPriceInput == true
            ? [CurrencyTextInputFormatter(locale: "pt-BR")]
            : null,
        keyboardType: isPriceInput == true ? TextInputType.number : null,
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
