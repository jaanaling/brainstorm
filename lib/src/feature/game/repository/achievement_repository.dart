

import 'package:brainstorm_quest/src/feature/game/model/achievement.dart';

import '../../../core/utils/json_loader.dart';

class AchievementRepository {
  final String key = 'achievements';

  Future<List<Achievement>> load() {
    return JsonLoader.loadData<Achievement>(
      key,
      'assets/json/$key.json',
      (json) => Achievement.fromMap(json),
    );
  }

  Future<void> update(Achievement updated) async {
    return JsonLoader.modifyDataList<Achievement>(
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

  Future<void> saveAll(List<Achievement> achievements) {
    return JsonLoader.saveAllData<Achievement>(
      key,
      achievements,
      (item) => item.toMap(),
    );
  }
}
