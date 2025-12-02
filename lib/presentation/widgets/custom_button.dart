import 'package:flutter/material.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? (7.h < 50 ? 50 : 7.h),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primaryBlue : AppColors.accentPurple,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        ),
        child: Text(
          text,
          style: AppTextStyles.buttonText(context),
        ),
      ),
    );
  }
}
