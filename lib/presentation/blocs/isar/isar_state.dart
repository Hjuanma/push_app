part of 'isar_bloc.dart';

class IsarState extends Equatable {
  final List<PushMessage> notifications;

  const IsarState({this.notifications = const []});

  IsarState copyWith({List<PushMessage>? notifications}) =>
      IsarState(notifications: notifications ?? this.notifications);

  @override
  List<Object> get props => [notifications];
}
