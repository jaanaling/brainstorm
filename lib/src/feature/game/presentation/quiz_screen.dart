import 'dart:async';
import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatefulWidget {
  final String puzzleId;

  const QuizScreen({super.key, required this.puzzleId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Timer _timer;
  int _secondsLeft = 90; // Начальное время таймера

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _timer.cancel();

        _showLoseDialog();
      }
    });
  }

  void _showLoseDialog() {
    final puzzle = context.read<AppBloc>().state is AppLoaded
        ? (context.read<AppBloc>().state as AppLoaded).puzzles.firstWhere(
              (p) => p.id == widget.puzzleId,
            )
        : null;

    if (puzzle != null) {
      for (int i = 0; i < puzzle.attempts; i++) {
        context.read<AppBloc>().add(CheckPuzzleSolution(widget.puzzleId, 4));
      }

      showWinDialog(context, false, puzzle);
    }
  }

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
          final puzzle = state.puzzles.firstWhere(
            (p) => p.id == widget.puzzleId,
          );

          return ScreenLayout(
            topSection: _buildHeader(puzzle),
            middleSection: _buildQuestionBox(),
            bottomSection: _buildKeyboard(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHeader(Puzzle puzzle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.timer, color: Colors.white),
        Text(
          "${_secondsLeft.toString().padLeft(2, '0')}", // Формат времени
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Row(
          children: [
            Icon(Icons.favorite, color: Colors.red),
            Text(puzzle.attempts.toString(),
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionBox() {
    return Container(
      color: Colors.deepPurple,
      margin: EdgeInsets.all(10),
      height: 150,
      width: double.infinity,
      child: Center(
        child: Text("Question?", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildKeyboard() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
      itemCount: 26,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showLoseDialog(),
          child: Card(
            color: Colors.pink,
            child: Center(
              child: Text(
                String.fromCharCode(97 + index),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

void showWinDialog(BuildContext context, bool isWinner, Puzzle puzzle) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Container(
          width:MediaQuery.of(context).size.width ,
          height: 217,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isWinner
                    ? IconProvider.alertW.buildImageUrl()
                    : IconProvider.alertL.buildImageUrl(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isWinner ? "YOU WIN" : "YOU LOSE",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isWinner)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "+${puzzle.coinsReward} Coins",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "+${puzzle.scoreReward} Score",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(isWinner ? "Next" : "Try Again"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
