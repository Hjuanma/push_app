import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/datasources/datasources.dart';
import '../../domain/entities/entities.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }
  @override
  Stream<List<PushMessage>> loadPushMessages(
      {int limit = 10, offset = 0}) async* {
    while (true) {
      final isar = await db;
      List<PushMessage> list = await isar.pushMessages
          .where()
          .sortBySentDateDesc()
          .offset(offset)
          .limit(limit)
          .findAll();
      yield list;
    }
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PushMessageSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> addPushMessages(PushMessage message) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.pushMessages.putSync(message));
  }
}
