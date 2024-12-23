import 'package:brainstorm_quest/src/core/utils/app_icon.dart';
import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(16),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () {

            },
            splashColor: Color(0xFFFF4AA7),
            child: Ink(
              width: 55,
              height: 55,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF5A008F),
                    Color(0xFFB100CD),
                    Color(0xFFFF4AA7)
                  ],
                ),
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFF3D0060)),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 3.40,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Center(
                child: Ink.image(
                  image: AssetImage(IconProvider.back.buildImageUrl()),
                  width: 46,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        GradientText(title, fontSize: 33),
        Spacer()
      ],
    );
  }
}
