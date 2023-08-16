import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/datasources/datasources.dart';
import '../../domain/entities/entities.dart';

class IsarDatasource  extends LocalStorageDatasource {
    late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }
  @override
  Future<List<PushMessage>> loadPushMessages({int limit = 10, offset = 0}) async {
     final isar = await db;
    return await isar.pushMessages.where().offset(offset).limit(limit).findAll();
  }
  
  Future<Isar> openDB() async{
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PushMessageSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
  
}