part of 'isar_bloc.dart';

sealed class IsarEvent {
  const IsarEvent();
}

class PushMessagesLoaded extends IsarEvent {
  PushMessagesLoaded();
}

class PushMessagesStarted extends IsarEvent {
  PushMessagesStarted();
}

class PushMessagesAdded extends IsarEvent {
  final PushMessage message;

  PushMessagesAdded(this.message);
}
