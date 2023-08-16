import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../../infrastructure/datasources/isar_datasource.dart';
import '../../../infrastructure/repositories/local_storage_repository_impl.dart';

part 'isar_event.dart';
part 'isar_state.dart';

class IsarBloc extends Bloc<IsarEvent, IsarState> {
  final localStorageRepository = LocalStorageRepositoryImpl(IsarDatasource());
  int page = 0;
  IsarBloc() : super(const IsarState()) {
    on<PushMessagesLoaded>(_onPushMessagesLoaded);
    on<PushMessagesAdded>(_onPushMessagesAdded);
  }

  void _onPushMessagesLoaded(
      PushMessagesLoaded event, Emitter<IsarState> emit) {
    emit(state.copyWith(
        notifications: [...state.notifications, ...event.notifications]));
  }

  void loadPushMessages() async {
    final messages = await localStorageRepository.loadPushMessages(
        offset: page * 15, limit: 15);
    page++;
    add(PushMessagesLoaded(messages));
  }

  void _onPushMessagesAdded(
      PushMessagesAdded event, Emitter<IsarState> emit) {
    emit(state.copyWith(
        notifications: [...state.notifications, event.message]));
  }

  void addPushMessages(PushMessage message) async {
    add(PushMessagesAdded(message));
  }
}
