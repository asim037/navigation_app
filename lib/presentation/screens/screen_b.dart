import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_app/presentation/widgets/custom_button.dart';
import 'package:navigation_app/presentation/widgets/hashtag_text_widget.dart';
import 'package:navigation_app/utils/constants/app_constants.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class ScreenB extends StatelessWidget {
  final String phrase;
  final String hashtags;
  final Color? hashtagColor;

  const ScreenB({
    super.key,
    required this.phrase,
    required this.hashtags,
    this.hashtagColor,
  });

  void _showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
          title: Text(
            AppConstants.congratulationsMessage,
            style: AppTextStyles.heading2(context),
            textAlign: TextAlign.center,
          ),
          content: Icon(
            Icons.celebration,
            size: 16.w,
            color: AppColors.hashtagColor,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(AppConstants.routeScreenA);
              },
              child: Text(
                'OK',
                style: AppTextStyles.buttonText(context).copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasData = phrase.isNotEmpty || hashtags.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          AppConstants.screenBTitle,
          style: AppTextStyles.heading2(context),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!hasData) ...[
                  Icon(
                    Icons.edit_note_rounded,
                    size: 30.w,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'No data yet',
                    style: AppTextStyles.heading2(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Navigate to Screen C to add your phrase and hashtags',
                    style: AppTextStyles.bodyMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2.5.w,
                          offset: Offset(0, 1.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phrase:',
                          style: AppTextStyles.heading3(context),
                        ),
                        SizedBox(height: 1.5.h),
                        HashtagTextWidget(
                          text: phrase,
                          hashtagColor: hashtagColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2.5.w,
                          offset: Offset(0, 1.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hashtags:',
                          style: AppTextStyles.heading3(context),
                        ),
                        SizedBox(height: 1.5.h),
                        HashtagTextWidget(
                          text: hashtags,
                          hashtagColor: hashtagColor,
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 4.h),
                CustomButton(
                  text: hasData ? AppConstants.done : AppConstants.navigateToC,
                  onPressed: () {
                    if (hasData) {
                      _showCongratulationsDialog(context);
                    } else {
                      context.go(AppConstants.routeScreenC);
                    }
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
