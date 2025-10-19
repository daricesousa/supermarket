import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final int maxLines;
  final Widget? suffixIcon;
  final bool enabled;
  const AppFormField({
    super.key,
    required this.label,
    this.controller,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.focusNode,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: suffixIcon,
      ),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
    );
  }
}
