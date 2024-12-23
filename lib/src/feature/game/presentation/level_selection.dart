import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/routes/go_router_config.dart';
import 'package:brainstorm_quest/routes/route_value.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:brainstorm_quest/ui_kit/app_bar.dart';
import 'package:brainstorm_quest/ui_kit/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui_kit/app_card.dart';
import '../../../../ui_kit/gradient_text_with_border.dart';
import '../../../core/utils/size_utils.dart';

class LevelSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AppError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        if (state is AppLoaded) {
          final levels = state.puzzles.map((el) => el.level).toSet().toList();
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  AppBarWidget(title:  'Select level'),
                  Gap(16),
                  _buildLevelList(context, levels, state.puzzles)
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLevelList(
    BuildContext context,
    List<int> levels,
    List<Puzzle> puzzles,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        children: List.generate(puzzles.length, (index) {
          final achievement = puzzles[index];

          bool isAvaible = puzzles.any((element) =>
              element.level ==
                  levels[index %
                      levels
                          .length] && // Используем модуль для предотвращения выхода за пределы
              element.status == PuzzleStatus.unlocked);

          final List<Puzzle> levelPuzzles = puzzles
              .where((element) =>
                  element.level ==
                  levels[index % levels.length]) // Аналогично используем модуль
              .toList();

          int allScore = levelPuzzles.fold<int>(0,
              (previousValue, element) => previousValue + element.scoreReward);
          int userScore = levelPuzzles
              .where((element) => element.status == PuzzleStatus.completed)
              .fold<int>(
                  0,
                  (previousValue, element) =>
                      previousValue + element.scoreReward);

          return AppCard(
            width: (getWidth(context, percent: 1) / 3) - 28,
            height: getHeight(context, baseSize: 140),
            onTap: (){
              context.push(
                  "${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.level.path}", extra: index + 1);
            },
            color: isAvaible ? AppContainerColor.green : AppContainerColor.grey,
            child: Column(
              children: [
                TextWithBorder(
                  text: 'Level ${index + 1}',
                  borderColor: const Color(0xFF075300),
                  fontSize: isIpad(context) ? 35 : 28,
                ),
                const Gap(4),
                TextWithBorder(
                  text: 'Score: $userScore',
                  borderColor: const Color(0xFF075300),
                  fontSize: isIpad(context) ? 27 : 20,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
