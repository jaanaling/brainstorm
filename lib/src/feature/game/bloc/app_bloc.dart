import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:brainstorm_quest/src/core/dependency_injection.dart';
import 'package:brainstorm_quest/src/core/utils/log.dart';
import 'package:brainstorm_quest/src/feature/game/model/achievement.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:brainstorm_quest/src/feature/game/repository/achievement_repository.dart';
import 'package:brainstorm_quest/src/feature/game/repository/repository.dart';
import 'package:brainstorm_quest/src/feature/game/repository/user_repository.dart';
import 'package:brainstorm_quest/src/feature/game/utils/puzzle_checker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final PuzzleRepository puzzleRepository = locator<PuzzleRepository>();
  final UserRepository userRepository = locator<UserRepository>();
  final AchievementRepository achievementRepository =
  locator<AchievementRepository>();

  AppBloc() : super(AppInitial()) {
    on<LoadData>(_onLoadData);
    on<CheckPuzzleSolution>(_onCheckPuzzleSolution);
    on<BuyHint>(_onBuyHint);
    on<UseHint>(_onUseHint);
  }

  Future<void> _onLoadData(LoadData event, Emitter<AppState> emit) async {
    emit(AppLoading());
    try {
      final puzzles = await puzzleRepository.load();
      final users = await userRepository.load();
      final achievements = await achievementRepository.load();

      logger.d(users);

      final user = users.isNotEmpty
          ? users.first
          : User(
        id: 1,
        name: "Player",
        points: 0,
        coins: 20,
        hints: 3,
        unlockedAchievements: [],
        completedPuzzles: [],
      );
      if (users.isEmpty) {
        await userRepository.save(user);
      }
      emit(AppLoaded(user, puzzles, achievements));
    } catch (e) {
      logger.e(e);
      emit(const AppError('Failed to load data'));
    }
  }

  Future<void> _onCheckPuzzleSolution(
      CheckPuzzleSolution event,
      Emitter<AppState> emit,
      ) async {
    final currentState = state;
    if (currentState is! AppLoaded) return;

    emit(AppCheckingPuzzle(currentState.puzzles));
    try {
      final puzzle = currentState.puzzles.firstWhere(
            (p) => p.id == event.puzzleId,
        orElse: () => throw Exception("Puzzle not found"),
      );
      if (puzzle.status != PuzzleStatus.unlocked) {
        // Если пазл не в статусе "unlocked", не обрабатываем решение
        emit(currentState);
        return;
      }

      bool isCorrect = false;
      if (event.userSolution != null) {
        switch (puzzle.type) {
          case PuzzleType.sumOfNumbers:
            isCorrect = checkSumOfNumbers(
              event.userSolution as List<int>,
              puzzle.solution as List<dynamic>,
            );
          case PuzzleType.logicalSequence:
            isCorrect = checkLogicalSequenceNext(
              event.userSolution as int,
              puzzle.solution as int,
            );
          case PuzzleType.mathEquation:
            isCorrect = checkMathEquation(
              event.userSolution as int,
              puzzle.solution as int,
            );
          case PuzzleType.symbolicAnagram:
            isCorrect = checkAnagramSolution(
              event.userSolution as String,
              puzzle.solution as String,
            );
          case PuzzleType.cipherCode:
            isCorrect = checkCipherSolution(
              event.userSolution as String,
              puzzle.solution as String,
            );
        }
      }

      Puzzle updatedPuzzle;
      User updatedUser = currentState.user;
      PuzzleStatus nextStatus = PuzzleStatus.unlocked;

      if (isCorrect) {
        updatedPuzzle = puzzle.copyWith(status: PuzzleStatus.completed);
        updatedUser = updatedUser.copyWith(
          points: updatedUser.points + puzzle.scoreReward,
          coins: updatedUser.coins + puzzle.coinsReward,
          completedPuzzles: [...updatedUser.completedPuzzles, puzzle.id],
        );
        nextStatus = PuzzleStatus.completed;
      } else {
        int newAttempts = puzzle.attempts - 1;
        PuzzleStatus newStatus = puzzle.status;
        if (newAttempts <= 0) {
          newStatus = PuzzleStatus.failed;
          nextStatus = PuzzleStatus.failed;
        }
        updatedPuzzle =
            puzzle.copyWith(attempts: newAttempts, status: newStatus);
      }

      // Вызываем callback, чтобы сообщить виджету, какой статус итоговый
      event.callback(nextStatus);

      // Обновляем пазл в списке
      List<Puzzle> updatedPuzzles = List.from(currentState.puzzles);
      final puzzleIndex =
      updatedPuzzles.indexWhere((p) => p.id == updatedPuzzle.id);
      updatedPuzzles[puzzleIndex] = updatedPuzzle;

      // Сохраняем пазлы и пользователя
      await puzzleRepository.saveAll(updatedPuzzles);
      await userRepository.update(updatedUser);

      // Теперь проверяем ачивки и возвращаем "нового" пользователя
      final checkResult =
      await _checkAchievements(updatedUser, currentState.achievements);
      final finalUser = checkResult.user; // <-- обновлённый User
      final finalAchievements = checkResult.achievements;

      // В итоге возвращаем в стейт нового пользователя
      emit(AppLoaded(finalUser, updatedPuzzles, finalAchievements));
    } catch (e) {
      logger.e(e);
      emit(const AppError('Failed to check puzzle solution'));
    }
  }

  Future<void> _onBuyHint(BuyHint event, Emitter<AppState> emit) async {
    final currentState = state;
    if (currentState is! AppLoaded) return;

    if (currentState.user.coins >= 15) {
      final updatedUser = currentState.user.copyWith(
        coins: currentState.user.coins - 15,
        hints: currentState.user.hints + 1,
      );

      await userRepository.update(updatedUser);

      // После покупки хинта также проверяем ачивки -> возвращаем нового пользователя
      final checkResult =
      await _checkAchievements(updatedUser, currentState.achievements);
      final finalUser = checkResult.user;
      emit(AppLoaded(finalUser, currentState.puzzles, checkResult.achievements));
    } else {
      emit(const AppError("Not enough coins to buy a hint"));
    }
  }

  Future<void> _onUseHint(UseHint event, Emitter<AppState> emit) async {
    final currentState = state;
    if (currentState is! AppLoaded) return;

    final puzzle = currentState.puzzles.firstWhere(
          (p) => p.id == event.puzzleId,
      orElse: () => throw Exception("Puzzle not found"),
    );

    if (puzzle.hints.isNotEmpty && currentState.user.hints > 0) {
      final updatedUser =
      currentState.user.copyWith(hints: currentState.user.hints - 1);
      await userRepository.update(updatedUser);

      // Проверяем ачивки после использования хинта
      final checkResult =
      await _checkAchievements(updatedUser, currentState.achievements);
      emit(AppLoaded(
        checkResult.user,
        currentState.puzzles,
        checkResult.achievements,
      ));
    } else {
      emit(const AppError("No hints available"));
    }
  }

  // ----------------- ВАЖНО: Меняем сигнатуру, чтобы вернуть (Achievements, User) -----------------
  Future<AchievementCheckResult> _checkAchievements(
      User user,
      List<Achievement> achievements,
      ) async {
    // Создаём копию пользователя, чтобы "прокручивать" все изменения здесь
    var localUser = user.copyWith();
    List<Achievement> updatedAchievements = List.from(achievements);

    for (int i = 0; i < updatedAchievements.length; i++) {
      final ach = updatedAchievements[i];
      if (!ach.unlocked) {
        // Проверяем разные условия и, при совпадении, апдейтим localUser
        if (ach.id == "complete_first_puzzle" &&
            localUser.completedPuzzles.isNotEmpty) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "rich_player" && localUser.coins >= 100) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "fifty_points" && localUser.points >= 50) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "ten_puzzles_done" &&
            localUser.completedPuzzles.length >= 10) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "buy_hint" && localUser.hints >= 1) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "solve_hard_puzzle") {
          // Проверяем, есть ли хоть один пазл со сложностью 4 среди завершённых
          bool hasHardPuzzle = false;

          final allPuzzles = state is AppLoaded
              ? (state as AppLoaded).puzzles
              : (state as AppCheckingPuzzle).puzzles;

          // Берём id всех пазлов c difficulty=4
          final hardPuzzleIds =
          allPuzzles.where((p) => p.difficulty == 4).map((p) => p.id);

          // Если localUser.completedPuzzles пересекается с hardPuzzleIds
          if (localUser.completedPuzzles
              .toSet()
              .intersection(hardPuzzleIds.toSet())
              .isNotEmpty) {
            hasHardPuzzle = true;
          }

          if (hasHardPuzzle) {
            updatedAchievements[i] = ach.copyWith(unlocked: true);
            localUser.unlockedAchievements.add(ach.id);
            localUser = localUser.copyWith(
              coins: localUser.coins + ach.coinReward,
            );
          }
        }

        if (ach.id == "100_coins" && localUser.coins >= 100) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "3_hints" && localUser.hints >= 3) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
          localUser.unlockedAchievements.add(ach.id);
          localUser = localUser.copyWith(
            coins: localUser.coins + ach.coinReward,
          );
        }

        if (ach.id == "finish_level_1") {
          bool finishedLevel1 = userHasCompletedAllLevel1Puzzles(localUser);
          if (finishedLevel1) {
            updatedAchievements[i] = ach.copyWith(unlocked: true);
            localUser.unlockedAchievements.add(ach.id);
            localUser = localUser.copyWith(
              coins: localUser.coins + ach.coinReward,
            );
          }
        }
      }
    }

    // Теперь обновляем данные в репозитории (Achievements + User)
    await achievementRepository.saveAll(updatedAchievements);

    // Сохраняем локального пользователя (с учётом возможных наград за ачивки)
    await userRepository.update(localUser);

    // Возвращаем итоговый объект
    return AchievementCheckResult(
      achievements: updatedAchievements,
      user: localUser,
    );
  }

  bool userHasCompletedAllLevel1Puzzles(User user) {
    List<String> level1PuzzleIds = getAllLevel1PuzzleIds();
    for (var p in level1PuzzleIds) {
      if (!user.completedPuzzles.contains(p)) {
        return false;
      }
    }
    return true;
  }

  List<String> getAllLevel1PuzzleIds() {
    final st = state;
    if (st is AppLoaded) {
      return st.puzzles
          .where((element) => element.level == 1)
          .map((e) => e.id)
          .toList();
    }
    final st2 = (st as AppCheckingPuzzle).puzzles;
    return st2.where((element) => element.level == 1).map((e) => e.id).toList();
  }
}

// Небольшой класс для удобства, чтобы вернуть (обновлённые ачивки, нового пользователя)
class AchievementCheckResult {
  final List<Achievement> achievements;
  final User user;

  AchievementCheckResult({
    required this.achievements,
    required this.user,
  });
}
