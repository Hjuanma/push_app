part of 'notications_bloc.dart';

abstract class NoticationsEvent{
  const NoticationsEvent();
}

class NotificationStatusChanged extends NoticationsEvent {

  final AuthorizationStatus status;

  NotificationStatusChanged(this.status);

}