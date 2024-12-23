import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/src/core/utils/app_icon.dart';
import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/src/core/utils/size_utils.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/achievement.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:brainstorm_quest/ui_kit/app_bar.dart';
import 'package:brainstorm_quest/ui_kit/app_card.dart';
import 'package:brainstorm_quest/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AchievementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (state is AppError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        if (state is AppLoaded) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  AppBarWidget(title: 'Achievements',),
                  _buildAchievementsList(
                      state.user, state.achievements, context)
                ], // Пустое пространство
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Список достижений
  Widget _buildAchievementsList(
      User user, List<Achievement> achievements, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        children: achievements.map((achievement) {
          return _buildAchievementCard(achievement, user, context);
        }).toList(),
      ),
    );
  }

  Widget _buildAchievementCard(
      Achievement achievement, User user, BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: getHeight(context, baseSize: 18)),
          child: AppCard(
            width: ((getWidth(context, percent: 1) / 3) - 28),
            height: getHeight(context, baseSize: 175),
            color: user.unlockedAchievements.contains(achievement.id)
                ? AppContainerColor.green
                : AppContainerColor.red,
            bottomShadowHeight: 5,
            child: null,
          ),
        ),
        Column(
          children: [
            AppIcon(
              asset: IconProvider.coins.buildImageUrl(),
              width: getWidth(context, baseSize: 52),
              height: getHeight(context, baseSize: 61),
            ),
            TextWithBorder(
                text: achievement.coinReward.toString(),
                borderColor: user.unlockedAchievements.contains(achievement.id)
                    ? Color(0xFF075300)
                    : Color(0xFF530000),
                fontSize: isIpad(context) ? 35 : 28),
            Gap(2),
            SizedBox(
              width: ((getWidth(context, percent: 1) / 3) - 28) - 20,
              height: isIpad(context) ?(38 * 2)  : (25*2),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextWithBorder(
                    textAlign: TextAlign.center,
                      text: achievement.title.replaceAll(" ", "\n"),
                      borderColor: user.unlockedAchievements.contains(achievement.id)
                          ? Color(0xFF075300)
                          : Color(0xFF530000),
                      fontSize: isIpad(context) ? 38 : 25),
                ),
              ),
            ),
            Gap(2),
            SizedBox(
   width: ((getWidth(context, percent: 1) / 3) - 28) - 20,
              child: Center(
                child: TextWithBorder(
                    textAlign: TextAlign.center,
                    text: achievement.description,
                    borderColor: user.unlockedAchievements.contains(achievement.id)
                        ? Color(0xFF075300)
                        : Color(0xFF530000),
                    fontSize: isIpad(context) ? 22 : 15),
              ),
            ),
          ],
        )
      ],
    );
  }
}
