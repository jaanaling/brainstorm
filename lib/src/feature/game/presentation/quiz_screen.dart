import 'dart:async';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends StatefulWidget {
  final String puzzleId;

  const QuizScreen({super.key, required this.puzzleId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Timer _timer;
  int _secondsLeft = 90;

  // Для sumOfNumbers
  List<int?> sumAnswer = []; // хранит выбранные числа. null - не заполнено
  List<int> availableNumbers = [];

  // Для logicalSequence / mathEquation
  int? selectedChoice;
  bool isError = false;
  bool isHintUsed = false;

  // Для symbolicAnagram / cipherCode
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showLoseDialog() {
    final puzzle = context.read<AppBloc>().state is AppLoaded
        ? (context.read<AppBloc>().state as AppLoaded)
            .puzzles
            .firstWhere((p) => p.id == widget.puzzleId)
        : null;

    if (puzzle != null) {
      for (int i = 0; i < puzzle.attempts; i++) {
        context.read<AppBloc>().add(
            CheckPuzzleSolution(puzzle.id, null, (PuzzleStatus status) {}));
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
          final puzzle =
              state.puzzles.firstWhere((p) => p.id == widget.puzzleId);

          // Инициализируем состояние для sumOfNumbers, если это данный тип
          if (puzzle.type == PuzzleType.sumOfNumbers && sumAnswer.isEmpty) {
            final solutionList = puzzle.solution as List;
            sumAnswer = List.filled(solutionList.length, null);
            availableNumbers = List<int>.from(puzzle.data['numbers'] as List);
            availableNumbers.sort();
          }

          return Scaffold(
            backgroundColor: Colors.black87,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(puzzle, state.user),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildInstructions(puzzle),
                          const SizedBox(height: 20),
                          _buildPuzzleWidget(puzzle),
                          const SizedBox(height: 20),
                          if (isError)
                            Text(
                              "You have error. Attempts: ${puzzle.attempts}",
                              style: TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 20),
                          if (isHintUsed)
                            Text(
                              "Hint: ${puzzle.hints}",
                              style: TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 20),
                          _buildConfirmButtonIfNeeded(puzzle),
                        ],
                      ),
                    ),
                  ),
                  _buildInputMethod(puzzle),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHeader(Puzzle puzzle, User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.timer, color: Colors.white),
        Text(
          "${_secondsLeft.toString().padLeft(2, '0')}",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red),
            Text(
              puzzle.attempts.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (!isHintUsed && user.hints > 0) {
                      isHintUsed = true;
                      context.read<AppBloc>().add(UseHint(widget.puzzleId));
                    }
                  });
                },
                icon: Icon(Icons.yard_rounded))
          ],
        ),
      ],
    );
  }

  Widget _buildInstructions(Puzzle puzzle) {
    return Container(
      color: Colors.deepPurple,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Center(
        child: Text(
          puzzle.instructions,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPuzzleWidget(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.sumOfNumbers:
        final target = puzzle.data['target'] as int;
        return Column(
          children: [
            Text(
              'Target: $target',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            // Отображаем ячейки для выбранных чисел
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: sumAnswer.map((val) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      val != null ? val.toString() : '',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      case PuzzleType.logicalSequence:
        final sequence = List<int>.from(puzzle.data['sequence'] as List);
        final options = List<int>.from(puzzle.data['options'] as List);
        return Column(
          children: [
            Text(
              "Sequence: ${sequence.join(", ")} , ?",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: options.map((opt) {
                return ChoiceChip(
                  label: Text('$opt'),
                  selected: selectedChoice == opt,
                  onSelected: (val) {
                    setState(() {
                      selectedChoice = val ? opt : null;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      case PuzzleType.mathEquation:
        final equation = puzzle.data['equation'] as String;
        final choices = List<int>.from(puzzle.data['choices'] as List);
        return Column(
          children: [
            Text(equation, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: choices.map((c) {
                return ChoiceChip(
                  label: Text('$c'),
                  selected: selectedChoice == c,
                  onSelected: (val) {
                    setState(() {
                      selectedChoice = val ? c : null;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      case PuzzleType.symbolicAnagram:
        final letters = List<String>.from(puzzle.data['letters'] as List);
        return Column(
          children: [
            Text(
              "Letters: ${letters.join(", ")}",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            // Можно добавить ячейки, но пока оставим textfield
            Container(
              color: Colors.white,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type the word',
                ),
              ),
            ),
          ],
        );
      case PuzzleType.cipherCode:
        final cipher = puzzle.data['cipher'] as String;
        final shift = puzzle.data['shift'] as int;
        return Column(
          children: [
            Text(
              'Cipher: $cipher (shift: $shift)',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type decoded text',
                ),
              ),
            ),
          ],
        );
      default:
        return const Text(
          'Unknown puzzle type',
          style: TextStyle(color: Colors.white),
        );
    }
  }

  Widget _buildConfirmButtonIfNeeded(Puzzle puzzle) {
    // Для logicalSequence и mathEquation нужен confirm
    // Для sumOfNumbers confirm будет на клавиатуре
    // Для anagram, cipher confirm на клавиатуре
    // Здесь только для logicalSequence и mathEquation
    if (puzzle.type == PuzzleType.logicalSequence ||
        puzzle.type == PuzzleType.mathEquation) {
      return ElevatedButton(
        onPressed: () => checkSolution(puzzle),
        child: const Text('CONFIRM'),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildInputMethod(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.symbolicAnagram:
      case PuzzleType.cipherCode:
        return _buildQWERTYKeyboard(puzzle);
      case PuzzleType.sumOfNumbers:
        return _buildRestrictedNumPad(puzzle);
      case PuzzleType.logicalSequence:
      case PuzzleType.mathEquation:
        // options + confirm уже есть
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRestrictedNumPad(Puzzle puzzle) {
    // Только символы из data["numbers"], + ⌫ и CONFIRM
    final numbers = List<int>.from(puzzle.data['numbers'] as List);
    // Сортируем для удобства
    numbers.sort();

    // Построим клавиатуру на основе доступных чисел
    // Например, если numbers = [1,9,2], мы сделаем клавиши [1,2,9] + ⌫ + CONFIRM
    List<String> keys = numbers.map((e) => e.toString()).toList();
    // Добавляем специальные клавиши
    // Поскольку нет HINT, оставим только ⌫ и CONFIRM
    // Расположим их внизу
    // Например:
    // [1][2][9]
    // [⌫][CONFIRM]
    // Можно по-разному располагать, ниже простой вариант:
    return Column(
      children: [
        Wrap(
          spacing: 10,
          children: keys.map((k) {
            return SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () => handleSumOfNumbersInput(k, puzzle),
                child: Text(
                  k,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () => handleSumOfNumbersInput('⌫', puzzle),
                child: const Text(
                  '⌫',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              height: 50,
              child: ElevatedButton(
                onPressed: () => checkSolution(puzzle),
                child: const Text(
                  'CONFIRM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void handleSumOfNumbersInput(String key, Puzzle puzzle) {
    setState(() {
      final solutionList = puzzle.solution as List;
      final maxLength = solutionList.length; // ограничение по кол-ву символов

      if (key == '⌫') {
        // Удаляем последний заполненный элемент
        for (int i = maxLength - 1; i >= 0; i--) {
          if (sumAnswer[i] != null) {
            sumAnswer[i] = null;
            break;
          }
        }
      } else {
        // Проверим, не превысили ли мы ограничение по длине
        // Найдем первую свободную ячейку
        int? freeIndex;
        for (int i = 0; i < maxLength; i++) {
          if (sumAnswer[i] == null) {
            freeIndex = i;
            break;
          }
        }
        if (freeIndex != null) {
          // Заполняем
          int val = int.parse(key);
          sumAnswer[freeIndex] = val;
        }
      }
    });
  }

  Widget _buildQWERTYKeyboard(Puzzle puzzle) {
    final keyboardRows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M', '⌫'],
      ['CONFIRM'],
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((letter) {
            bool isWideButton = (letter == 'CONFIRM' || letter == 'HINT');
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
              child: SizedBox(
                width: isWideButton ? 160 : 40,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () => handleQWERTYInput(letter, puzzle),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      letter,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void handleQWERTYInput(String letter, Puzzle puzzle) {
    setState(() {
      if (letter == 'CONFIRM') {
        checkSolution(puzzle);
      } else if (letter == '⌫') {
        if (textController.text.isNotEmpty) {
          textController.text =
              textController.text.substring(0, textController.text.length - 1);
        }
      } else {
        textController.text += letter;
      }
    });
  }

  void checkSolution(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.sumOfNumbers:
        context.read<AppBloc>().add(
              CheckPuzzleSolution(
                  widget.puzzleId, sumAnswer.map((e) => e ?? 0).toList(),
                  (PuzzleStatus status) {
                if (status == PuzzleStatus.completed) {
                  showWinDialog(context, true, puzzle);
                }
                if (status == PuzzleStatus.failed) {
                  showWinDialog(context, false, puzzle);
                } else {
                  isError = true;
                }
              }),
            );
      case PuzzleType.mathEquation:
      case PuzzleType.logicalSequence:
        context.read<AppBloc>().add(CheckPuzzleSolution(
                widget.puzzleId, selectedChoice ?? 0, (PuzzleStatus status) {
              if (status == PuzzleStatus.completed) {
                showWinDialog(context, true, puzzle);
              }
              if (status == PuzzleStatus.failed) {
                showWinDialog(context, false, puzzle);
              } else {
                isError = true;
              }
            }));
      case PuzzleType.cipherCode:
      case PuzzleType.symbolicAnagram:
        context.read<AppBloc>().add(CheckPuzzleSolution(
                widget.puzzleId, textController.text.toUpperCase(),
                (PuzzleStatus status) {
              if (status == PuzzleStatus.completed) {
                showWinDialog(context, true, puzzle);
              }
              if (status == PuzzleStatus.failed) {
                showWinDialog(context, false, puzzle);
              } else {
                isError = true;
              }
            }));
    }
  }

  void showWinDialog(BuildContext context, bool isWinner, Puzzle puzzle) {
    _timer.cancel();
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
            width: MediaQuery.of(context).size.width,
            height: 217,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isWinner ? 'YOU WIN' : 'YOU LOSE',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isWinner)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+${puzzle.coinsReward} Coins',
                        style:
                            const TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      Text(
                        '+${puzzle.scoreReward} Score',
                        style:
                            const TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context
                      ..pop()
                      ..pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: Text(isWinner ? 'Next' : 'Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
