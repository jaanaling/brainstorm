import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/src/core/utils/size_utils.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/achievement.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:brainstorm_quest/ui_kit/app_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  _buildAchievementsList(state.user, state.achievements, context)
                ], // Пустое пространство
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Кнопка "назад" сверху
  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  // Список достижений
  Widget _buildAchievementsList(User user, List<Achievement> achievements, BuildContext context) {
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

  Widget _buildAchievementCard(Achievement achievement, User user, BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.monetization_on, color: Colors.yellow, size: 36),
          SizedBox(height: 8),
          Text(achievement.coinReward.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 8),
          Text(achievement.title,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Text(achievement.description,
              style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
      width: ((getWidth(context, percent: 1) / 3) - 28),
      height: getHeight(context, baseSize: 111),
      color: user.unlockedAchievements.contains(achievement.id)
          ? AppContainerColor.green
          : AppContainerColor.red,
      bottomShadowHeight: 5,
    );
  }
}
