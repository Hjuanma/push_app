part of 'notications_bloc.dart';

class NoticationsState extends Equatable {
  final AuthorizationStatus status;

//TODO: Crear modelo de notificaciones
  final List<dynamic> notifications;

  const NoticationsState(
      {this.status = AuthorizationStatus.notDetermined,
      this.notifications = const []});

  NoticationsState copyWith(
          AuthorizationStatus? status, List<dynamic>? notifications) =>
      NoticationsState(
          notifications: notifications ?? this.notifications,
          status: status ?? this.status);

  @override
  List<Object> get props => [status, notifications];
}
