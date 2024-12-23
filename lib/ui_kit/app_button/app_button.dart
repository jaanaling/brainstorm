import 'dart:ffi';

import 'package:brainstorm_quest/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_glow/inner_glow.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final ButtonColors color;
  @override
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width = 336,
      this.height = 100,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: InnerGlow(
        width: width,
        height: height,
        thickness: 44,
        glowBlur: 20,
        glowRadius: 22,
        strokeLinearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color == ButtonColors.purple
                  ? Color(0xFFD74EFF)
                  : Color(0xFFFFEA4E),
              color == ButtonColors.purple
                  ? Color(0xFF9C01FF)
                  : Color(0xFFFFA905),
            ]),
        baseDecoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.87, 2.5),
            stops: [0.05, 0.57, 0.57, 0.8],
            radius: 3.5,
            colors: color == ButtonColors.purple
                ? [
                    Color(0xFF9C00FF),
                    Color(0xFF9C00FF),
                    Color(0xFFC31EFE),
                    Color(0xFFD32AFE)
                  ]
                : [
                    Color(0xFFFFA500),
                    Color(0xFFFFA600),
                    Color(0xFFF6FE1E),
                    Color(0xFFF7FE1E)
                  ],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
            child: TextWithBorder(
                text: text, borderColor: Color(0xFF340052), fontSize: 34)),
      ),
    );
  }
}

enum ButtonColors { purple, yellow }
