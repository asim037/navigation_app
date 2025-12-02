import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_app/presentation/widgets/custom_button.dart';
import 'package:navigation_app/utils/constants/app_constants.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          AppConstants.screenATitle,
          style: AppTextStyles.heading2(context),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_rounded,
                  size: 30.w,
                  color: AppColors.primaryBlue,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Welcome to Screen A',
                  style: AppTextStyles.heading1(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Start your journey by navigating to Screen B',
                  style: AppTextStyles.bodyMedium(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6.h),
                CustomButton(
                  text: AppConstants.navigateToB,
                  onPressed: () {
                    context.go(AppConstants.routeScreenB);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
