import 'package:brainstorm_quest/src/feature/game/repository/achievement_repository.dart';
import 'package:brainstorm_quest/src/feature/game/repository/repository.dart';
import 'package:brainstorm_quest/src/feature/game/repository/user_repository.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => PuzzleRepository());
  locator.registerLazySingleton(() => AchievementRepository());
  locator.registerLazySingleton(() => UserRepository());
}
