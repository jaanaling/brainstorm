import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/routes/route_value.dart';
import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LevelScreen extends StatelessWidget {
  final int levelId;

  @override
  const LevelScreen({super.key, required this.levelId});

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
          final puzzles =
              state.puzzles.where((puzzle) => puzzle.level == levelId).toList();

          final int allScore = puzzles.fold<int>(
            0,
            (previousValue, element) => previousValue + element.scoreReward,
          );
          final int userScore = puzzles
              .where((element) => element.status == PuzzleStatus.completed)
              .fold<int>(
                0,
                (previousValue, element) => previousValue + element.scoreReward,
              );
          return ScreenLayout(
            topSection: _buildBackButtonAndTitle(context, levelId),
            middleSection: _buildLevelContent(context, puzzles),
            bottomSection: _buildProgressIndicator(allScore, userScore),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Верхняя секция с кнопкой "назад" и названием уровня
  Widget _buildBackButtonAndTitle(BuildContext context, int levelId) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              context.pop();
            },
          ),
          Text(
            "LEVEL $levelId",
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 40), // Пустое пространство
        ],
      ),
    );
  }

  // Средняя секция с шариками и характеристиками уровней
  Widget _buildLevelContent(BuildContext context, List<Puzzle> puzzles) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.separated(
          reverse: true,
          itemCount: 4,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Gap(6),
          itemBuilder: (context, difficultyIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'X${difficultyIndex + 1}',
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: puzzles
                        .where(
                          (e) =>
                              e.level == levelId &&
                              e.difficulty == difficultyIndex + 1,
                        )
                        .map(
                          (challenge) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: buildBall(
                              challenge,
                              context,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBall(Puzzle challenge, BuildContext context) {
    String image;
    switch (challenge.status) {
      case PuzzleStatus.locked:
        image = 'assets/images/grey_ball.png';
      case PuzzleStatus.unlocked:
        image = IconProvider.yellowB.buildImageUrl();
      case PuzzleStatus.completed:
        image = IconProvider.greenB.buildImageUrl();
      case PuzzleStatus.failed:
        image = IconProvider.redB.buildImageUrl();
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(
          '${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.level.path}/${RouteValue.quiz.path}',
          extra: challenge.id,
        ),
        borderRadius: BorderRadius.circular(32),
        child: Ink.image(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          fit: BoxFit.cover,
          image: AssetImage(
            image,
          ),
        ),
      ),
    );
  }

  // Ряд с шариками и их количеством

  // Нижняя секция с прогрессом уровня
  Widget _buildProgressIndicator(int score, int userScore) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  value: 0.5, // Пример значения прогресса
                  strokeWidth: 12,
                  color: Colors.pink,
                ),
              ),
              Text(
                score.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            (score - userScore).toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
