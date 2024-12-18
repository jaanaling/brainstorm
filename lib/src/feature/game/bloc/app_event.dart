part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class LoadData extends AppEvent {}

class CheckPuzzleSolution extends AppEvent {
  final String puzzleId;
  final dynamic userSolution;

  const CheckPuzzleSolution(this.puzzleId, this.userSolution);

  @override
  List<Object?> get props => [puzzleId, userSolution];
}

class ClaimAchievement extends AppEvent {
  final String achievementId;
  const ClaimAchievement(this.achievementId);

  @override
  List<Object?> get props => [achievementId];
}

class BuyHint extends AppEvent {}
