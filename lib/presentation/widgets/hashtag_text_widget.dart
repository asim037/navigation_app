import 'package:flutter/material.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';

class HashtagTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final TextStyle? hashtagStyle;
  final Color? hashtagColor;

  const HashtagTextWidget({
    super.key,
    required this.text,
    this.baseStyle,
    this.hashtagStyle,
    this.hashtagColor,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    final baseTextStyle = baseStyle ?? AppTextStyles.bodyLarge(context);
    final defaultHashtagStyle = AppTextStyles.hashtagText(context);
    
    final baseHashtagStyle = hashtagStyle ?? defaultHashtagStyle;
    final finalHashtagColor = hashtagColor ?? baseHashtagStyle.color;
    final hashtagTextStyle = baseHashtagStyle.copyWith(color: finalHashtagColor);

    final regex = RegExp(r'#\w+');
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return Text(text, style: baseTextStyle);
    }

    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseTextStyle,
        ));
      }

      spans.add(TextSpan(
        text: match.group(0),
        style: hashtagTextStyle,
      ));

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseTextStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
