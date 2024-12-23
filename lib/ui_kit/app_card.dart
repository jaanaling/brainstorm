import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_glow/inner_glow.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final double borderRadius;
  final double width;
  final double height;
  final AppContainerColor color;
  final VoidCallback? onTap;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final double bottomShadowHeight;
  const AppCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    required this.width,
    required this.height,
    required this.color,
    this.onTap,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.bottomShadowHeight = 2,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = color == AppContainerColor.red
        ? [Color(0xFFFF4287), Color(0xFFE00000)]
        : color == AppContainerColor.green
            ? [Color(0xFF42FFD3), Color(0xFF3BE000)]
            : color == AppContainerColor.grey
                ? [Color(0xFFB3B3B3), Color(0xFF6C6C6C)]
                : color == AppContainerColor.pink
                    ? [Color(0xFFFF80CC), Color(0xFFF269FF)]
                    : [Color(0xFFA4D0F0), Color(0xFF75A0D7)];

    final bottomShadowColor = color == AppContainerColor.red
        ? Color(0xFF7D0000)
        : color == AppContainerColor.green
            ? Color(0xFF0F7D00)
            : color == AppContainerColor.grey
                ? Color(0xFF424242)
                : color == AppContainerColor.pink
                    ? Color(0xFF921FAE)
                    : Color(0xFF1F37AE);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius ?? borderRadius),
          bottomLeft: Radius.circular(bottomLeftRadius ?? borderRadius),
          topRight: Radius.circular(topRightRadius ?? borderRadius),
          bottomRight: Radius.circular(bottomRightRadius ?? borderRadius),
        )),
        splashColor: gradientColors.first,
        child: Stack(
          children: [
            Ink(
              width: width,
              height: height + bottomShadowHeight,
              decoration: BoxDecoration(
                  color: bottomShadowColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topLeftRadius ?? borderRadius),
                    bottomLeft:
                        Radius.circular(bottomLeftRadius ?? borderRadius),
                    topRight: Radius.circular(topRightRadius ?? borderRadius),
                    bottomRight:
                        Radius.circular(bottomRightRadius ?? borderRadius),
                  )),
            ),
            Ink(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: gradientColors),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topLeftRadius ?? borderRadius),
                    bottomLeft:
                        Radius.circular(bottomLeftRadius ?? borderRadius),
                    topRight: Radius.circular(topRightRadius ?? borderRadius),
                    bottomRight:
                        Radius.circular(bottomRightRadius ?? borderRadius),
                  )),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

enum AppContainerColor { red, green, grey, blue, pink }
