import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/app_theme.dart';

class CustomTextField extends HookWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final String hintText;
  final bool hasFloatingPlaceholder;
  final TextInputType? keyboardType;
  final int maxLength;
  final void Function(String)? onSubmit;
  final void Function(String?)? onSave;
  final Function(String)? onChange;
  final TextStyle? style;
  final TextAlign textAlign;
  final Widget? suffixWidget;
  final String? prefixText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputeFormatter;
  final bool? enabled;
  final Function()? onTap;
  final Color? color;

  const CustomTextField({
    Key? key,
    this.maxLength = 20,
    this.controller,
    this.obscureText = false,
    this.hintText = '',
    this.hasFloatingPlaceholder = true,
    this.keyboardType = TextInputType.phone,
    this.onSubmit,
    this.onChange,
    this.focusNode,
    this.style,
    this.textAlign = TextAlign.center,
    this.suffixWidget,
    this.prefixText,
    this.validator,
    this.inputeFormatter,
    this.enabled,
    this.onTap,
    this.color = const Color(0xff3D4B6B),
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSave,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      enabled: enabled,
      inputFormatters: inputeFormatter,
      validator: validator,
      textAlign: textAlign,
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      maxLength: maxLength,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      style: style,
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: suffixWidget,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        hintText: hasFloatingPlaceholder ? null : hintText,
        hintStyle: AppTheme.fontCreator(fontColor: Colors.white54, fontSize: 10),
        counterText: '',
        alignLabelWithHint: true,
        floatingLabelBehavior: hasFloatingPlaceholder ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
        labelText: hintText,
        labelStyle: AppTheme.fontCreator(fontColor: Colors.white54, fontSize: 10),
        fillColor: color,
        filled: true,
        prefixStyle: AppTheme.fontCreator(),
        prefixText: prefixText,
      ),
    );
  }
}
