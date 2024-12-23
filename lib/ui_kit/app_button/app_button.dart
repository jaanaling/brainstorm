import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_glow/inner_glow.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  @override
  const AppButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: InnerGlow(
        width: 336,
        height: 100,
        thickness: 44,
        glowBlur: 35,
        strokeLinearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD74EFF),
              Color(0xFF9C01FF),
            ]),
        baseDecoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.87, 2.5),
            stops: [0.05, 0.57, 0.57, 0.8],
            radius: 3.5,
            colors: [
              Color(0xFF9C00FF),
              Color(0xFF9C00FF),
              Color(0xFFC31EFE),
              Color(0xFFD32AFE)
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
      ),
    );
  }
}
