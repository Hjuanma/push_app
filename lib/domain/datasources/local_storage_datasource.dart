import 'package:push_app/domain/entities/entities.dart';

abstract class LocalStorageDatasource {
  Future<List<PushMessage>> loadPushMessages({int limit = 10, offset = 0});
}