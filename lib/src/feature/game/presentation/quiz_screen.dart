import 'dart:async';
import 'dart:math';
import 'package:brainstorm_quest/ui_kit/app_button/app_button.dart';
import 'package:brainstorm_quest/ui_kit/app_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:brainstorm_quest/ui_kit/app_bar.dart';
import 'package:brainstorm_quest/ui_kit/gradient_text_with_border.dart';

class QuizScreen extends StatefulWidget {
  final String puzzleId;
  const QuizScreen({super.key, required this.puzzleId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Timer _timer;
  int _secondsLeft = 90;

  // Состояния для разных типов головоломок
  // --------------------------------------
  // Сумма чисел
  List<int?> sumAnswer = [];
  List<int> availableNumbers = [];

  // Логическая последовательность / мат. выражение
  int? selectedChoice;
  bool isError = false;

  // Анаграмма / Шифр
  final textController = TextEditingController();

  bool isHintUsed = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer.cancel();
        _showLoseDialog(); // Если время вышло
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showLoseDialog() {
    final appState = context.read<AppBloc>().state;
    if (appState is! AppLoaded) return;

    final puzzle = appState.puzzles.firstWhere((p) => p.id == widget.puzzleId);
    // Автоматически потратили все попытки
    for (int i = 0; i < puzzle.attempts; i++) {
      context.read<AppBloc>().add(CheckPuzzleSolution(puzzle.id, null, (_) {}));
    }
    _showPuzzleResultDialog(false, puzzle);
  }

  void _useHint(User user) {
    if (!isHintUsed && user.hints > 0) {
      setState(() => isHintUsed = true);
      context.read<AppBloc>().add(UseHint(widget.puzzleId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (_, state) {
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
            _initSumOfNumbersIfNeeded(puzzle);

            return SafeArea(
              child: Column(
                children: [
                  _buildHeader(puzzle, state.user),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Gap(20),
                          _buildInstructions(puzzle),
                          const Gap(40),
                          _buildPuzzleContainer(puzzle),
                          const Gap(20),
                          if (isError)
                            const TextWithBorder(
                              text: 'Incorrect, try again!',
                              borderColor: Colors.red,
                              fontSize: 20,
                            ),
                          const Gap(20),
                          if (isHintUsed)
                            TextWithBorder(
                              text: 'Hint: ${puzzle.hints}',
                              borderColor: Colors.black,
                              fontSize: 20,
                            ),
                          const Gap(20),
                          _buildConfirmButtonIfNeeded(puzzle),
                        ],
                      ),
                    ),
                  ),
                  _buildPuzzleKeyboard(puzzle),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ------------------ Вспомогательная инициализация ------------------
  void _initSumOfNumbersIfNeeded(Puzzle puzzle) {
    if (puzzle.type == PuzzleType.sumOfNumbers && sumAnswer.isEmpty) {
      final solutionList = puzzle.solution as List;
      sumAnswer = List.filled(solutionList.length, null);
      availableNumbers = List<int>.from(puzzle.data['numbers'] as List)..sort();
    }
  }

  // ------------------ UI-методы (шапка, инструкции, контейнеры) ------------------
  Widget _buildHeader(Puzzle puzzle, User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const AppBackButton(),
          const Spacer(),
          _buildStatusColumn(
            IconProvider.timer.buildImageUrl(),
            _secondsLeft.toString().padLeft(2, '0'),
          ),
          const Gap(30),
          _buildStatusColumn(
            IconProvider.hp.buildImageUrl(),
            puzzle.attempts.toString(),
          ),
          const Gap(20),
          CupertinoButton(
            onPressed: () => isHintUsed ? null : _useHint(user),
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                _buildStatusColumn(
                  IconProvider.hint.buildImageUrl(),
                  user.hints.toString(),
                ),
                if (isHintUsed)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.white,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusColumn(String iconPath, String value) {
    return Column(
      children: [
        Image.asset(iconPath, width: 56, height: 66),
        const Gap(7),
        TextWithBorder(text: value, fontSize: 23, borderColor: Colors.black),
      ],
    );
  }

  Widget _buildInstructions(Puzzle puzzle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GradientText(
        puzzle.instructions,
        isCenter: true,
        fontSize: 32,
      ),
    );
  }

  Widget _buildPuzzleContainer(Puzzle puzzle) {
    return Container(
      width: 330,
      height: 171,
      decoration: BoxDecoration(
        color: const Color(0xFF230162),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF6123CE), width: 2),
      ),
      child: _buildPuzzleWidget(puzzle),
    );
  }

  // ------------------ Основной виджет для текущего puzzle ------------------
  Widget _buildPuzzleWidget(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.sumOfNumbers:
        return _buildSumOfNumbersWidget(puzzle);
      case PuzzleType.logicalSequence:
        return _buildLogicalSequenceWidget(puzzle);
      case PuzzleType.mathEquation:
        return _buildMathEquationWidget(puzzle);
      case PuzzleType.symbolicAnagram:
        return _buildSymbolicAnagramWidget(puzzle);
      case PuzzleType.cipherCode:
        return _buildCipherCodeWidget(puzzle);
      default:
        return const Text(
          'Unknown puzzle type',
          style: TextStyle(color: Colors.white),
        );
    }
  }

  Widget _buildSumOfNumbersWidget(Puzzle puzzle) {
    final target = puzzle.data['target'] as int;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHelpText('Target: $target'),
        const Gap(10),
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
                  val?.toString() ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLogicalSequenceWidget(Puzzle puzzle) {
    final sequence = List<int>.from(puzzle.data['sequence'] as List);
    final options = List<int>.from(puzzle.data['options'] as List);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHelpText("Sequence: ${sequence.join(", ")} , ?"),
        const Gap(10),
        _buildChoiceChips(options),
      ],
    );
  }

  Widget _buildMathEquationWidget(Puzzle puzzle) {
    final equation = puzzle.data['equation'] as String;
    final choices = List<int>.from(puzzle.data['choices'] as List);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHelpText(equation),
        const Gap(10),
        _buildChoiceChips(choices),
      ],
    );
  }

  Widget _buildSymbolicAnagramWidget(Puzzle puzzle) {
    final letters = List<String>.from(puzzle.data['letters'] as List);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHelpText("Letters: ${letters.join(", ")}"),
        const Gap(10),
        _buildTextField(),
      ],
    );
  }

  Widget _buildCipherCodeWidget(Puzzle puzzle) {
    final cipher = puzzle.data['cipher'] as String;
    final shift = puzzle.data['shift'] as int;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHelpText('Cipher: $cipher (shift: $shift)'),
        const Gap(10),
        _buildTextField(),
      ],
    );
  }

  CupertinoTextField _buildTextField() {
    return CupertinoTextField(
      controller: textController,
      textAlign: TextAlign.center,
      readOnly: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
      placeholder: 'Answer',
      placeholderStyle: const TextStyle(color: Colors.grey, fontSize: 24),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }

  TextWithBorder _buildHelpText(String text) {
    return TextWithBorder(
      text: text,
      fontSize: 20,
      borderColor: Colors.black,
    );
  }

  Wrap _buildChoiceChips(List<int> choices) {
    return Wrap(
      spacing: 10,
      children: choices.map((c) {
        return ChoiceChip(
          selectedColor: Color(0xFF921FAE),
          checkmarkColor: Colors.white,
          label: TextWithBorder(
            text: '$c',
            borderColor: Colors.black,
            fontSize: 18,
          ),
          selected: selectedChoice == c,
          onSelected: (val) => setState(() => selectedChoice = val ? c : null),
        );
      }).toList(),
    );
  }

  // ------------------ Кнопка подтверждения (если нужно) ------------------
  Widget _buildConfirmButtonIfNeeded(Puzzle puzzle) {
    // Для логической последовательности / мат. выражения нужна кнопка
    if (puzzle.type == PuzzleType.logicalSequence ||
        puzzle.type == PuzzleType.mathEquation) {
      return AppButton(
        onPressed: () => _checkSolution(puzzle),
        width: 225,
        height: 72,
        color: ButtonColors.purple,
        text: 'CONFIRM',
      );
    }
    return const SizedBox.shrink();
  }

  // ------------------ Клавиатура / Ввод для разных типов ------------------
  Widget _buildPuzzleKeyboard(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.sumOfNumbers:
        return _buildRestrictedNumPad(puzzle);
      case PuzzleType.symbolicAnagram:
      case PuzzleType.cipherCode:
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
          child: _buildQWERTYKeyboard(puzzle),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRestrictedNumPad(Puzzle puzzle) {
    // Клавиатура для sumOfNumbers
    final numbers = List<int>.from(puzzle.data['numbers'] as List)..sort();

    return Column(
      children: [
        Wrap(
          spacing: 10,
          children: numbers.map((num) {
            double? topLeftRadius = num == numbers.first ? 20 : null;
            double? topRightRadius = num == numbers.last ? 20 : null;
            return _buildNumPadButton(
              label: num.toString(),
              puzzle: puzzle,
              topLeftRadius: topLeftRadius,
              topRightRadius: topRightRadius,
            );
          }).toList(),
        ),
        const Gap(10),
        Wrap(
          spacing: 10,
          children: [
            _buildNumPadButton(
              label: '⌫',
              puzzle: puzzle,
              bottomLeftRadius: 20,
            ),
            AppCard(
              width: 61 * numbers.length - 71,
              height: 61,
              borderRadius: 2,
              bottomRightRadius: 20,
              color: AppContainerColor.pink,
              onTap: () => _checkSolution(puzzle),
              child: Center(
                child: FittedBox(
                  child: TextWithBorder(
                    text: 'CONFIRM',
                    borderColor: Colors.black,
                    fontSize: 33,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumPadButton({
    required String label,
    required Puzzle puzzle,
    double? topLeftRadius,
    double? bottomRightRadius,
    double? topRightRadius,
    double? bottomLeftRadius,
  }) {
    return AppCard(
      color: AppContainerColor.pink,
      width: 51,
      height: 61,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      bottomRightRadius: bottomRightRadius,
      bottomLeftRadius: bottomLeftRadius,
      onTap: () => _handleNumPadInput(label, puzzle),
      borderRadius: 2,
      child: Center(
        child: TextWithBorder(
          text: label,
          borderColor: Colors.black,
          fontSize: 33,
        ),
      ),
    );
  }

  void _handleNumPadInput(String key, Puzzle puzzle) {
    setState(() {
      final solutionList = puzzle.solution as List;
      final maxLen = solutionList.length;

      if (key == '⌫') {
        // Удаляем последний заполненный
        for (int i = maxLen - 1; i >= 0; i--) {
          if (sumAnswer[i] != null) {
            sumAnswer[i] = null;
            break;
          }
        }
      } else {
        // Добавляем число в первую свободную ячейку
        final idx = sumAnswer.indexWhere((e) => e == null);
        if (idx != -1) {
          sumAnswer[idx] = int.parse(key);
        }
      }
    });
  }

  Widget _buildQWERTYKeyboard(Puzzle puzzle) {
    final keyboardRows = [
      ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z'],
      ['⌫', 'X', 'C', 'V', 'B', 'N', 'M', 'CONFIRM'],
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((char) {
            bool isWide = (char == 'CONFIRM');
            bool isNum =
                int.tryParse(char) != null || char == '⌫' || char == 'CONFIRM';

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2),
              child: AppCard(
                onTap: () => _handleQWERTYInput(char, puzzle),
                borderRadius: 2,
                topLeftRadius: char == '0' ? 20 : null,
                topRightRadius: char == '9' ? 20 : null,
                bottomLeftRadius: char == '⌫' ? 20 : null,
                bottomRightRadius: char == 'CONFIRM' ? 20 : null,
                color: isNum ? AppContainerColor.pink : AppContainerColor.blue,
                width: isWide ? 105 : 32,
                height: 40,
                child: FittedBox(
                  child: TextWithBorder(
                    text: char,
                    borderColor: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void _handleQWERTYInput(String char, Puzzle puzzle) {
    int length = 0;
    if (puzzle.type == PuzzleType.symbolicAnagram) {
      length = (puzzle.data['letters'] as List).length;
    } else if (puzzle.type == PuzzleType.cipherCode) {
      length = (puzzle.data['cipher'] as String).length;
    }
    setState(() {
      if (char == 'CONFIRM') {
        _checkSolution(puzzle);
      } else if (char == '⌫') {
        if (textController.text.isNotEmpty) {
          textController.text =
              textController.text.substring(0, textController.text.length - 1);
        }
      } else {
        if (textController.text.characters.length < length) {
          textController.text += char;
          textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length),
          );
        }
      }
    });
  }

  // ------------------ Проверка решения ------------------
  void _checkSolution(Puzzle puzzle) {
    switch (puzzle.type) {
      case PuzzleType.sumOfNumbers:
        _puzzleCheck(puzzle, sumAnswer.map((e) => e ?? 0).toList());
      case PuzzleType.mathEquation:
      case PuzzleType.logicalSequence:
        _puzzleCheck(puzzle, selectedChoice ?? 0);
      case PuzzleType.symbolicAnagram:
      case PuzzleType.cipherCode:
        _puzzleCheck(puzzle, textController.text.toUpperCase());
      default:
        // Ничего не делаем
        break;
    }
  }

  void _puzzleCheck(Puzzle puzzle, dynamic answer) {
    context.read<AppBloc>().add(
          CheckPuzzleSolution(widget.puzzleId, answer, (PuzzleStatus status) {
            switch (status) {
              case PuzzleStatus.completed:
                _showPuzzleResultDialog(true, puzzle);
              case PuzzleStatus.failed:
                _showPuzzleResultDialog(false, puzzle);
              default:
                setState(() => isError = true);
            }
          }),
        );
  }

  // ------------------ Диалоговый результат ------------------
  void _showPuzzleResultDialog(bool isWinner, Puzzle puzzle) {
    _timer.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: 217,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isWinner ? 'YOU WIN' : 'YOU LOSE',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isWinner)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+${puzzle.coinsReward} Coins ',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '+${puzzle.scoreReward} Score',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(isWinner ? 'Next' : 'Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
