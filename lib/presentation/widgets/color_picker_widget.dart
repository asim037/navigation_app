import 'package:flutter/material.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class ColorPickerWidget extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorPickerWidget({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hashtag Color:',
          style: AppTextStyles.heading3(context),
        ),
        SizedBox(height: 1.5.h),
        Row(
          children: AppColors.hashtagColorOptions.map((color) {
            final isSelected = color.value == selectedColor.value;
            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                margin: EdgeInsets.only(right: 4.w),
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primaryBlue : AppColors.borderLight,
                    width: isSelected ? 3 : 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 6.w,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

