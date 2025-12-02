import 'package:flutter/material.dart';
import 'package:navigation_app/utils/helpers/hashtag_suggestions.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';
import 'package:navigation_app/utils/styles/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class HashtagAutocompleteField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const HashtagAutocompleteField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<HashtagAutocompleteField> createState() =>
      _HashtagAutocompleteFieldState();
}

class _HashtagAutocompleteFieldState extends State<HashtagAutocompleteField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _suggestions = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    widget.focusNode?.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    widget.focusNode?.removeListener(_onFocusChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged() {
    if (!mounted) return;
    
    final text = widget.controller.text;
    final cursorPosition = widget.controller.selection.baseOffset.clamp(0, text.length);
    final query = HashtagSuggestions.getCurrentHashtagQuery(text, cursorPosition);

    if (query != null && query.length > 1) {
      final suggestions = HashtagSuggestions.getSuggestions(query);
      if (suggestions.isNotEmpty) {
        _showSuggestions(suggestions);
      } else {
        _removeOverlay();
      }
    } else {
      _removeOverlay();
    }
  }

  void _onFocusChanged() {
    if (widget.focusNode?.hasFocus != true) {
      _removeOverlay();
    }
  }

  void _showSuggestions(List<String> suggestions) {
    _removeOverlay();
    _suggestions = suggestions;
    _selectedIndex = -1;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _suggestions = [];
    _selectedIndex = -1;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(3.w),
            child: Container(
              constraints: BoxConstraints(maxHeight: 20.h),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  final isSelected = index == _selectedIndex;
                  return InkWell(
                    onTap: () => _selectSuggestion(suggestion),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      color: isSelected
                          ? AppColors.backgroundLight
                          : Colors.transparent,
                      child: Text(
                        suggestion,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          color: AppColors.hashtagColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectSuggestion(String suggestion) {
    final text = widget.controller.text;
    final cursorPosition = widget.controller.selection.baseOffset.clamp(0, text.length);
    final beforeCursor = text.substring(0, cursorPosition);
    final afterCursor = text.substring(cursorPosition);

    final lastHashIndex = beforeCursor.lastIndexOf('#');
    if (lastHashIndex == -1) return;

    final beforeHash = text.substring(0, lastHashIndex);
    final spaceAfter = afterCursor.isEmpty || afterCursor.startsWith(' ') || afterCursor.startsWith(',') ? '' : ' ';
    final newText = '$beforeHash$suggestion$spaceAfter$afterCursor';
    final newCursorPosition = (lastHashIndex + suggestion.length + spaceAfter.length).clamp(0, newText.length);

    widget.controller.text = newText;
    widget.controller.selection = TextSelection.collapsed(
      offset: newCursorPosition,
    );

    _removeOverlay();
    widget.onChanged?.call(newText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.heading3(context),
        ),
        SizedBox(height: 1.5.h),
        CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            onChanged: widget.onChanged,
            style: AppTextStyles.bodyLarge(context),
            decoration: InputDecoration(
              hintText: widget.hintText,
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
        ),
      ],
    );
  }
}

