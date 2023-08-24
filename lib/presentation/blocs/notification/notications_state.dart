part of 'notications_bloc.dart';

class NoticationsState extends Equatable {
  final AuthorizationStatus status;

  final PushMessage? lastNotification;

  const NoticationsState(
      {this.status = AuthorizationStatus.notDetermined,
      this.lastNotification});

  NoticationsState copyWith(
          {AuthorizationStatus? status, PushMessage? lastNotification}) =>
      NoticationsState(
          lastNotification: lastNotification ?? this.lastNotification,
          status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
