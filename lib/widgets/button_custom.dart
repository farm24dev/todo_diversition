import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    this.text,
    this.onPressed,
    this.backgroundColor = Colours.primary,
    this.fontSize,
    this.height,
    this.width,
  });
  final String? text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double? fontSize;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final double btnHeight = height ?? 48;
    return SizedBox(
      height: btnHeight,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          minimumSize: Size(88, btnHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text ?? 'Button Custom',
          style: AppTextStyles.medium.copyWith(
            fontSize: fontSize ?? (btnHeight * 0.4),
            color: Colours.white,
          ),
        ),
      ),
    );
  }
}
