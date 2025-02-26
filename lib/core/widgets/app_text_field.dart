import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.title,
    this.initialValue,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.inputType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 255,
    this.readOnly = false,
    this.helperText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    this.obscureText = false,
    this.isRequired = false,
    TextEditingController? controller,
  }) {
    this.controller = controller ?? TextEditingController();
    if (initialValue?.isNotEmpty == true) {
      this.controller?.text = initialValue!;
    }
  }

  final String title;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputType inputType;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool readOnly;
  final bool isRequired;
  final String? helperText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  late final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        // if(title.containsValidValue) CaptionText(title: title!, isRequired: isRequired),
        Text(title, style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500
        ),),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            counterText: '',
            counter: const SizedBox.shrink(),
            suffixIcon: suffixIcon,
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.litePrewinkle),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.litePrewinkle),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.litePrewinkle),
            ),
            filled: true,
            fillColor: Colors.white24,
          ),
          obscuringCharacter: '*',
          textInputAction: TextInputAction.done,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: inputType,
          minLines: minLines,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          textCapitalization: TextCapitalization.none,
          readOnly: readOnly,
          autocorrect: false,
          autofocus: autofocus,
        ),
      ],
    );
  }
}
