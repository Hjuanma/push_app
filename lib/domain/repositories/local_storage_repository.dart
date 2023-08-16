import '../entities/entities.dart';

abstract class LocalStorageRepository {
  Future<List<PushMessage>> loadPushMessages({int limit = 10, offset = 0});
  Future<void> addPushMessages(PushMessage message);
}