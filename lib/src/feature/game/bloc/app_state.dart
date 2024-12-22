part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppInitial extends AppState {}
class AppLoading extends AppState {}
class AppError extends AppState {
  final String message;
  const AppError(this.message);
  @override
  List<Object?> get props => [message];
}

class AppLoaded extends AppState {
  final User user;
  final List<Puzzle> puzzles;
  final List<Achievement> achievements;

  const AppLoaded(this.user, this.puzzles, this.achievements);

  @override
  List<Object?> get props => [user, puzzles, achievements];
}

class AppCheckingPuzzle extends AppState {
    final List<Puzzle> puzzles;

  const AppCheckingPuzzle(this.puzzles);
  @override
  List<Object?> get props => [puzzles];

}
