import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../../infrastructure/datasources/isar_datasource.dart';
import '../../../infrastructure/repositories/local_storage_repository_impl.dart';

part 'isar_event.dart';
part 'isar_state.dart';

class IsarBloc extends Bloc<IsarEvent, IsarState> {
  final _localStorageRepository = LocalStorageRepositoryImpl(IsarDatasource());
  int page = 0;

  IsarBloc() : super(const IsarState()) {
    on<PushMessagesLoaded>(_onPushMessagesLoaded);
    on<PushMessagesAdded>(_onPushMessagesAdded);
    on<PushMessagesStarted>(_onPushMessagesStarted);
  }

  void _onPushMessagesLoaded(
      PushMessagesLoaded event, Emitter<IsarState> emit) async{
    await emit.forEach(
      _localStorageRepository.loadPushMessages(offset: page * 15, limit: 15),
      onData: (List<PushMessage> data) =>
          state.copyWith(notifications: data),
    );
  }
  void _onPushMessagesStarted(
      PushMessagesStarted event, Emitter<IsarState> emit) async{
    await emit.forEach(
      _localStorageRepository.loadPushMessages(offset: page * 15, limit: 15),
      onData: (List<PushMessage> data) =>
          state.copyWith(notifications: data),
    );
  }

  void loadPushMessages(){
    page++;
    add(PushMessagesLoaded());
  }

  void startPushMessages(){
    add(PushMessagesLoaded());
  }

  void _onPushMessagesAdded(PushMessagesAdded event, Emitter<IsarState> emit) {
    emit(
        state.copyWith(notifications: [...state.notifications, event.message]));
  }

  void addPushMessages(PushMessage message) async {
    add(PushMessagesAdded(message));
  }

  PushMessage? getMessageById(String pushMessageId) {
    final exist = state.notifications.any(
      (element) => element.messageId == pushMessageId,
    );

    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}
