import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart' as gradientText;

class GradientText extends StatelessWidget {
  final bool isCenter;
  const GradientText(
    this.text, {
    required this.fontSize,
    this.isCenter = false,
    super.key,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: isCenter ? TextAlign.center : null,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            fontFamily: 'Gulya',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Color(0xFF5F0B0C),
          ),
        ),
        gradientText.GradientText(
        text,
          textAlign: isCenter ? TextAlign.center : null,
          style: TextStyle(
            color: Color(0xFFFFF700),
            fontSize: fontSize,
            fontFamily: 'Gulya',
          ),
          gradientDirection: gradientText.GradientDirection.ttb,
          gradientType: gradientText.GradientType.linear,
          stops: [
            0,
            0.5,
            1,
          ],
          colors: [
            Color(0xFFFDFCFC),
            Color(0xFFFFF700),
            Color(0xFFFF5900),
          ],
        ),
      ],
    );
  }
}

class TextWithBorder extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color? color;
  final double fontSize;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final String? fontFamily;
  final TextOverflow? overflow;

  const TextWithBorder({
    super.key,
    required this.text,
    required this.borderColor,
    required this.fontSize,
    this.letterSpacing,
    this.textAlign,
    this.fontFamily,
    this.color,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'Gulya',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = borderColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'Gulya',
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
