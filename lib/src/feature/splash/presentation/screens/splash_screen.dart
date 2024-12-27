import 'package:brainstorm_quest/src/core/utils/size_utils.dart';
import 'package:core_logic/core_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../routes/route_value.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/icon_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitializationCubit()..initialize(context),
      child: BlocListener<InitializationCubit, InitializationState>(
        listener: (context, state) {
          if (state is InitializedState) {
            context.go(state.startRoute);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      IconProvider.background.buildImageUrl(),
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: getHeight(context, baseSize: 213),
              child: AppIcon(asset: IconProvider.logo.buildImageUrl()),
              width: 328,
              height: 249,
            ),
            Positioned(
              bottom: getHeight(context, baseSize: 38),
              child: SizedBox(
                width: 111.74,
                height: 111.74,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CupertinoActivityIndicator(
                    color: Color(0xFFFA53D6),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
