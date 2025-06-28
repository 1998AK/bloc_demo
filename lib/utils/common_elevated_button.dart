import 'package:bloc_demo/utils/common_text_widget.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class CommonElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon;
  final EdgeInsetsGeometry padding;
  final OutlinedBorder? shape;
  final Color? borderColor;
  final double elevation;

  const CommonElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 48,
    this.borderRadius = 14,
    this.backgroundColor = appColor,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.shape,
    this.borderColor,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: elevation,
      padding: padding,
      minimumSize: Size(width ?? double.infinity, height ?? 40),
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
          ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: icon != null
          ?
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: 8),
          CommonButtonTextWidget(text: text)
        ],
      )
          :
      CommonButtonTextWidget(text: text),
    );
  }
}
