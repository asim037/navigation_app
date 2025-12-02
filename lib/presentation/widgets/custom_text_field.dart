import 'package:flutter/material.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.heading3(context),
        ),
        SizedBox(height: 1.5.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          focusNode: focusNode,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          style: AppTextStyles.bodyLarge(context),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.bodyMedium(context),
            filled: true,
            fillColor: AppColors.backgroundWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: const BorderSide(color: AppColors.borderFocus, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          ),
        ),
      ],
    );
  }
}
