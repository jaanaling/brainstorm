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
    on<ClaimAchievement>(_onClaimAchievement);
    on<BuyHint>(_onBuyHint);
  }

  Future<void> _onLoadData(LoadData event, Emitter<AppState> emit) async {
    emit(AppLoading());
    try {
      final puzzles = await puzzleRepository.load();
      final users = await userRepository.load();
      final achievements = await achievementRepository.load();

      final user = users.isNotEmpty
          ? users.first
          : User(
              id: 1,
              name: "Player",
              points: 0,
              coins: 20, // например, начальные монеты
              hints: 3,
              unlockedAchievements: [],
              completedPuzzles: [],
            );
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

    emit(AppCheckingPuzzle());
    try {
      final puzzle = currentState.puzzles.firstWhere(
        (p) => p.id == event.puzzleId,
        orElse: () => throw Exception("Puzzle not found"),
      );
      if (puzzle.status != PuzzleStatus.unlocked) {
        emit(currentState);
        return;
      }

      bool isCorrect = false;
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
            puzzle.solution as List<String>,
          );

        case PuzzleType.cipherCode:
          isCorrect = checkCipherSolution(
            event.userSolution as String,
            puzzle.solution as String,
          );
      }

      Puzzle updatedPuzzle;
      User updatedUser = currentState.user;

      if (isCorrect) {
        updatedPuzzle = puzzle.copyWith(status: PuzzleStatus.completed);
        updatedUser = updatedUser.copyWith(
          points: updatedUser.points + puzzle.scoreReward,
          coins: updatedUser.coins + puzzle.coinsReward,
          completedPuzzles: [...updatedUser.completedPuzzles, puzzle.id],
        );
      } else {
        int newAttempts = puzzle.attempts - 1;
        PuzzleStatus newStatus = puzzle.status;
        if (newAttempts <= 0) {
          newStatus = PuzzleStatus.failed;
        }
        updatedPuzzle =
            puzzle.copyWith(attempts: newAttempts, status: newStatus);
      }

      List<Puzzle> updatedPuzzles = List.from(currentState.puzzles);
      final puzzleIndex =
          updatedPuzzles.indexWhere((p) => p.id == updatedPuzzle.id);
      updatedPuzzles[puzzleIndex] = updatedPuzzle;

      await puzzleRepository.saveAll(updatedPuzzles);
      await userRepository.update(updatedUser);

      final updatedAchievements =
          await _checkAchievements(updatedUser, currentState.achievements);

      emit(AppLoaded(updatedUser, updatedPuzzles, updatedAchievements));
    } catch (e) {
      logger.e(e);
      emit(const AppError('Failed to check puzzle solution'));
    }
  }

  Future<void> _onClaimAchievement(
    ClaimAchievement event,
    Emitter<AppState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AppLoaded) return;

    final achievement = currentState.achievements.firstWhere(
      (a) => a.id == event.achievementId,
      orElse: () => throw Exception("Achievement not found"),
    );
    if (achievement.unlocked) {
      emit(currentState);
      return;
    }

    final updatedAchievement = achievement.copyWith(unlocked: true);

    final updatedUser = currentState.user.copyWith(
      coins: currentState.user.coins + achievement.coinReward,
      unlockedAchievements: [
        ...currentState.user.unlockedAchievements,
        achievement.id,
      ],
    );

    List<Achievement> updatedAchievements =
        List.from(currentState.achievements);
    final index = updatedAchievements.indexWhere((a) => a.id == achievement.id);
    updatedAchievements[index] = updatedAchievement;

    await achievementRepository.saveAll(updatedAchievements);
    await userRepository.update(updatedUser);

    emit(AppLoaded(updatedUser, currentState.puzzles, updatedAchievements));
  }

  Future<void> _onBuyHint(BuyHint event, Emitter<AppState> emit) async {
    final currentState = state;
    if (currentState is! AppLoaded) return;

    // Покупка подсказки за 10 монет
    if (currentState.user.coins >= 10) {
      final updatedUser = currentState.user.copyWith(
        coins: currentState.user.coins - 10,
        hints: currentState.user.hints + 1,
      );

      await userRepository.update(updatedUser);

      emit(
        AppLoaded(
          updatedUser,
          currentState.puzzles,
          currentState.achievements,
        ),
      );
    } else {
      // Недостаточно монет
      emit(const AppError("Not enough coins to buy a hint"));
    }
  }

  Future<List<Achievement>> _checkAchievements(
    User user,
    List<Achievement> achievements,
  ) async {
    List<Achievement> updatedAchievements = List.from(achievements);

    for (int i = 0; i < updatedAchievements.length; i++) {
      final ach = updatedAchievements[i];
      if (!ach.unlocked) {
        // Примеры условий:
        if (ach.id == "complete_first_puzzle" &&
            user.completedPuzzles.isNotEmpty) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
        }

        if (ach.id == "rich_player" && user.coins >= 100) {
          updatedAchievements[i] = ach.copyWith(unlocked: true);
        }

        // Можно добавить ещё условия для других ачивок
      }
    }

    await achievementRepository.saveAll(updatedAchievements);

    return updatedAchievements;
  }
}
