import '../entities/entities.dart';

abstract class LocalStorageRepository {
  Stream<List<PushMessage>> loadPushMessages({int limit = 10, offset = 0});
  Future<void> addPushMessages(PushMessage message);
}