import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_app/presentation/widgets/color_picker_widget.dart';
import 'package:navigation_app/presentation/widgets/custom_button.dart';
import 'package:navigation_app/presentation/widgets/custom_text_field.dart';
import 'package:navigation_app/presentation/widgets/hashtag_autocomplete_field.dart';
import 'package:navigation_app/presentation/widgets/hashtag_text_widget.dart';
import 'package:navigation_app/utils/constants/app_constants.dart';
import 'package:navigation_app/utils/helpers/hashtag_helper.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class ScreenC extends StatefulWidget {
  const ScreenC({super.key});

  @override
  State<ScreenC> createState() => _ScreenCState();
}

class _ScreenCState extends State<ScreenC> {
  final TextEditingController _phraseController = TextEditingController();
  final TextEditingController _hashtagsController = TextEditingController();
  final FocusNode _phraseFocusNode = FocusNode();
  final FocusNode _hashtagsFocusNode = FocusNode();
  Color _selectedHashtagColor = AppColors.defaultHashtagColor;

  @override
  void initState() {
    super.initState();
    _phraseController.addListener(_onPhraseChanged);
  }

  void _onPhraseChanged() {
    if (!_hashtagsFocusNode.hasFocus) {
      final hashtags = HashtagHelper.extractHashtags(_phraseController.text);
      final formattedHashtags = HashtagHelper.formatHashtags(hashtags);
      _hashtagsController.text = formattedHashtags;
    }

    setState(() {});
  }

  void _onSubmit() {
    final phrase = _phraseController.text.trim();
    final hashtags = _hashtagsController.text.trim();
    final colorValue = _selectedHashtagColor.value.toString();

    context.go(
      '${AppConstants.routeScreenB}?phrase=${Uri.encodeComponent(phrase)}&hashtags=${Uri.encodeComponent(hashtags)}&color=$colorValue',
    );
  }

  @override
  void dispose() {
    _phraseController.dispose();
    _hashtagsController.dispose();
    _phraseFocusNode.dispose();
    _hashtagsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          AppConstants.screenCTitle,
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
                HashtagAutocompleteField(
                  label: AppConstants.phraseLabel,
                  hintText: 'Enter your phrase with #hashtags',
                  controller: _phraseController,
                  maxLines: 5,
                  onChanged: (_) => setState(() {}),
                  focusNode: _phraseFocusNode,
                ),
                SizedBox(height: 2.h),
                if (_phraseController.text.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preview:',
                          style: AppTextStyles.bodyMedium(context),
                        ),
                        SizedBox(height: 1.h),
                        HashtagTextWidget(
                          text: _phraseController.text,
                          hashtagColor: _selectedHashtagColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
                HashtagAutocompleteField(
                  label: AppConstants.hashtagsLabel,
                  hintText: '#hashtag1, #hashtag2, #hashtag3',
                  controller: _hashtagsController,
                  maxLines: 3,
                  focusNode: _hashtagsFocusNode,
                ),
                SizedBox(height: 3.h),
                ColorPickerWidget(
                  selectedColor: _selectedHashtagColor,
                  onColorSelected: (color) {
                    setState(() {
                      _selectedHashtagColor = color;
                    });
                  },
                ),
                SizedBox(height: 4.h),
                CustomButton(
                  text: AppConstants.submit,
                  onPressed: _onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
