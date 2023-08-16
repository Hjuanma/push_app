part of 'isar_bloc.dart';

sealed class IsarEvent {
  const IsarEvent();
}

class PushMessagesLoaded extends IsarEvent {
  final List<PushMessage> notifications;

  PushMessagesLoaded(this.notifications);
}

class PushMessagesAdded extends IsarEvent {
  final PushMessage message;

  PushMessagesAdded(this.message);
}
