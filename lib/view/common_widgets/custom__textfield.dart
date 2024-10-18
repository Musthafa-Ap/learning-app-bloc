import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final String? prefixText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLines;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.contentPadding,
    this.prefix,
    this.prefixText,
    this.errorText,
    this.keyboardType,
    this.maxLength,
    this.minLines,
    this.onChanged,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.suffixText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    bool obscureText = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          maxLines: isPassword ? 1 : maxLines,
          enabled: enabled,
          readOnly: readOnly ?? false,
          onTap: onTap,
          controller: controller,
          obscureText: obscureText,
          maxLength: maxLength,
          minLines: minLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixText: suffixText,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(.5),
                )),
            prefixIcon: prefix,
            errorText: errorText,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: hintText,
            prefixText: prefixText,
            // isDense: true,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
        );
      },
    );
  }
}
