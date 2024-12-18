import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';

import '../../../core/utils/json_loader.dart';

class PuzzleRepository {
  final String key = 'puzzles';

  Future<List<Puzzle>> load() {
    return JsonLoader.loadData<Puzzle>(
      key,
      'assets/json/$key.json',
      (json) => Puzzle.fromMap(json),
    );
  }

  Future<void> update(Puzzle updated) async {
    return JsonLoader.modifyDataList<Puzzle>(
      key,
      updated,
      () async => await load(),
      (item) => item.toMap(),
      (itemList) async {
        final index = itemList.indexWhere((d) => d.id == updated.id);
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }

  Future<void> save(Puzzle item) {
    return JsonLoader.saveData<Puzzle>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<void> remove(Puzzle item) {
    return JsonLoader.removeData<Puzzle>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<Puzzle?> getById(int id) async {
    final puzzles = await load();
    if (puzzles.isEmpty) return null;

    return puzzles.firstWhere((puzzle) => puzzle.id == id);
  }

  Future<void> saveAll(List<Puzzle> puzzles) {
    return JsonLoader.saveAllData<Puzzle>(
      key,
      puzzles,
      (item) => item.toMap(),
    );
  }
}
