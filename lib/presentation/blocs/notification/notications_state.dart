part of 'notications_bloc.dart';

class NoticationsState extends Equatable {
  final AuthorizationStatus status;

  final List<PushMessaage> notifications;

  const NoticationsState(
      {this.status = AuthorizationStatus.notDetermined,
      this.notifications = const []});

  NoticationsState copyWith(
          {AuthorizationStatus? status, List<PushMessaage>? notifications}) =>
      NoticationsState(
          notifications: notifications ?? this.notifications,
          status: status ?? this.status);

  @override
  List<Object> get props => [status, notifications];
}
