import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PuzzleScreen extends StatefulWidget {
  final String puzzleId;
  const PuzzleScreen({Key? key, required this.puzzleId}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  final TextEditingController _textController = TextEditingController();
  List<int> selectedNumbers = [];
  int chosenValue = 0;
  Map<String, String> userMatches = {};
  int mathAnswer = 0;
  String anagramSolution = '';
  String cipherGuess = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is AppLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (state is AppError) {
        return Scaffold(body: Center(child: Text(state.message)));
      }
      if (state is AppLoaded) {
        final puzzle = state.puzzles.firstWhere(
          (p) => p.id == widget.puzzleId,
        );

        if (puzzle == null) {
          return const Scaffold(body: Center(child: Text("Puzzle not found")));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Puzzle #${puzzle.id}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.help),
                onPressed: () {
                  context.read<AppBloc>().add(BuyHint());
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(puzzle.instructions),
                const SizedBox(height: 20),
                if (state.user.hints > 0 && puzzle.hints.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _showHintDialog(context, puzzle.hints.first);
                    },
                    child: Text("Use Hint (You have ${state.user.hints})"),
                  )
                else if (puzzle.hints.isNotEmpty && state.user.hints == 0)
                  const Text("No hints available. Buy a hint for 10 coins."),
                const SizedBox(height: 20),
                buildPuzzleUI(puzzle),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final userSolution = getUserSolutionForPuzzle(puzzle.type);
                    context
                        .read<AppBloc>()
                        .add(CheckPuzzleSolution(puzzle.id, userSolution));
                  },
                  child: const Text("Check Solution"),
                ),
                const SizedBox(height: 20),
                Text("Status: ${puzzle.status.toString().split('.').last}"),
              ],
            ),
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }

  Widget buildPuzzleUI(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.sumOfNumbers:
        final numbers = (puzzle.data["numbers"] as List<dynamic>)
            .map((e) => e as int)
            .toList();
        final target = puzzle.data["target"] as int;
        return Column(
          children: [
            Text("Select numbers that add up to $target"),
            Wrap(
              spacing: 8,
              children: numbers.map((num) {
                final isSelected = selectedNumbers.contains(num);
                return ChoiceChip(
                  label: Text(num.toString()),
                  selected: isSelected,
                  onSelected: (sel) {
                    setState(() {
                      if (sel) {
                        selectedNumbers.add(num);
                      } else {
                        selectedNumbers.remove(num);
                      }
                    });
                  },
                );
              }).toList(),
            )
          ],
        );

      case PuzzleType.logicalSequence:
        final options = (puzzle.data["options"] as List<dynamic>)
            .map((e) => e as int)
            .toList();
        final seq = (puzzle.data["sequence"] as List<dynamic>)
            .map((e) => e as int)
            .toList();
        return Column(
          children: [
            Text("Complete the sequence: ${seq.join(', ')} , ?"),
            DropdownButton<int>(
              value: chosenValue == 0 ? null : chosenValue,
              hint: const Text("Select next number"),
              items: options
                  .map((o) =>
                      DropdownMenuItem(value: o, child: Text(o.toString())))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  chosenValue = val!;
                });
              },
            )
          ],
        );

      case PuzzleType.mathEquation:
        final choices = (puzzle.data["choices"] as List<dynamic>)
            .map((e) => e as int)
            .toList();
        final eq = puzzle.data["equation"] as String;
        return Column(
          children: [
            Text(eq),
            DropdownButton<int>(
              value: mathAnswer == 0 ? null : mathAnswer,
              hint: const Text("Select answer"),
              items: choices
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c.toString())))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  mathAnswer = val!;
                });
              },
            )
          ],
        );

      case PuzzleType.symbolicAnagram:
        final letters = (puzzle.data["letters"] as List<dynamic>)
            .map((e) => e as String)
            .toList();
        return Column(
          children: [
            Text("Rearrange letters: ${letters.join(', ')}"),
            TextField(
              decoration: const InputDecoration(labelText: "Your word"),
              onChanged: (val) {
                anagramSolution = val;
              },
            )
          ],
        );

      case PuzzleType.cipherCode:
        final cipher = puzzle.data["cipher"];
        return Column(
          children: [
            Text("Decode the message: $cipher"),
            TextField(
              decoration:
                  const InputDecoration(labelText: "Your decoded message"),
              onChanged: (val) {
                cipherGuess = val;
              },
            )
          ],
        );
    }
  }

  dynamic getUserSolutionForPuzzle(PuzzleType type) {
    switch (type) {
      case PuzzleType.sumOfNumbers:
        return selectedNumbers;
      case PuzzleType.logicalSequence:
        return chosenValue;

      case PuzzleType.mathEquation:
        return mathAnswer;
      case PuzzleType.symbolicAnagram:
        return anagramSolution;

      case PuzzleType.cipherCode:
        return cipherGuess;
    }
  }

  void _showHintDialog(BuildContext context, String hint) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hint"),
        content: Text(hint),
        actions: [
          TextButton(
            onPressed: () =>context.pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
