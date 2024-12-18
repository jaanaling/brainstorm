import 'package:brainstorm_quest/src/feature/game/model/user.dart';

import '../../../core/utils/json_loader.dart';

class UserRepository {
  final String key = 'user';

  Future<List<User>> load() {
    return JsonLoader.loadData<User>(
      key,
      'assets/json/$key.json',
      (json) => User.fromMap(json),
    );
  }

  Future<void> update(User updated) async {
    return JsonLoader.modifyDataList<User>(
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

  Future<void> save(User item) {
    return JsonLoader.saveData<User>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<void> remove(User item) {
    return JsonLoader.removeData<User>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<User?> getById(int id) async {
    final users = await load();
    if (users.isEmpty) return null;
    
    return users.firstWhere((user) => user.id == id);
  }

  Future<void> saveAll(List<User> users) {
    return JsonLoader.saveAllData<User>(
      key,
      users,
      (item) => item.toMap(),
    );
  }
}