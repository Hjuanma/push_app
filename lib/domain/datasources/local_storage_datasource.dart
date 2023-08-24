import 'package:push_app/domain/entities/entities.dart';

abstract class LocalStorageDatasource {
  Stream<List<PushMessage>> loadPushMessages({int limit = 10, offset = 0});
  Future<void> addPushMessages(PushMessage message);
}