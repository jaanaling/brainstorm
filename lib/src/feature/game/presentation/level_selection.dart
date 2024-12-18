import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/routes/go_router_config.dart';
import 'package:brainstorm_quest/routes/route_value.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LevelSelectScreen extends StatelessWidget {
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
          final levels = state.puzzles.map((el) => el.level).toSet().toList();
          return ScreenLayout(
            topSection: _buildBackButton(context),
            middleSection: _buildLevelList(context, levels, state.puzzles),
            bottomSection: SizedBox.shrink(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

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

  Widget _buildLevelList(
      BuildContext context, List<int> levels, List<Puzzle> puzzles) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        bool isAvaible = puzzles.any((element) =>
            element.level == levels[index] &&
            element.status == PuzzleStatus.unlocked);

        final List<Puzzle> levelPuzzles =
            puzzles.where((element) => element.level == levels[index]).toList();

        int allScore = levelPuzzles.fold<int>(
            0, (previousValue, element) => previousValue + element.scoreReward);
        int userScore = levelPuzzles
            .where((element) => element.status == PuzzleStatus.completed)
            .fold<int>(
                0,
                (previousValue, element) =>
                    previousValue + element.scoreReward);

        return CupertinoButton(
          onPressed: () {
            context.push(
                "${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.level.path}", extra: index + 1);
          },
          child: Card(
            color: !isAvaible ? Colors.deepPurple : Colors.green,
            child: Center(
                child: Column(
              children: [
                Text("Level ${index + 1}",
                    style: TextStyle(color: Colors.white)),
                Text("Score: ${userScore}/${allScore}")
              ],
            )),
          ),
        );
      },
    );
  }
}
