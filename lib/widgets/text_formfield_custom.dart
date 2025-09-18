import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_diversition/constants/colours.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    this.controller,
    this.hintText,
    this.lines = 1,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int lines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: lines,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      keyboardType:
          keyboardType ??
          (textInputAction == TextInputAction.newline
              ? TextInputType.multiline
              : TextInputType.text),
      decoration: InputDecoration(
        border: _buildInputBorder(),
        focusedBorder: _buildInputBorder(),
        enabledBorder: _buildInputBorder(),
        errorBorder: _buildInputBorder().copyWith(
          borderSide: const BorderSide(color: Colours.red, width: 1),
        ),
        focusedErrorBorder: _buildInputBorder().copyWith(
          borderSide: const BorderSide(color: Colours.red, width: 1),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colours.primary, width: 1),
    );
  }
}
