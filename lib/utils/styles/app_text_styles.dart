import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {
  static TextStyle heading1(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF212121),
      height: 1.2,
    );
  }

  static TextStyle heading2(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF212121),
      height: 1.3,
    );
  }

  static TextStyle heading3(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF212121),
      height: 1.4,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF212121),
      height: 1.5,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF757575),
      height: 1.5,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF9E9E9E),
      height: 1.4,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: 0.5,
    );
  }

  static TextStyle hashtagText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFE91E63),
    );
  }
}
