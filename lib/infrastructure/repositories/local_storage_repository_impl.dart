import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/domain/repositories/repositories.dart';

import '../../domain/datasources/datasources.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);
  
  @override
  Stream<List<PushMessage>> loadPushMessages({int limit = 10, offset = 0}) async* {
    yield* datasource.loadPushMessages(limit: limit, offset: offset);
  }
  
  @override
  Future<void> addPushMessages(PushMessage message) async {
    return await datasource.addPushMessages(message);
  }
  
}