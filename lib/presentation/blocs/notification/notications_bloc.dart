import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../firebase_options.dart';

part 'notications_event.dart';
part 'notications_state.dart';

class NoticationsBloc extends Bloc<NoticationsEvent, NoticationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NoticationsBloc() : super(const NoticationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NoticationsState> emit) {
    emit(state.copyWith(status: event.status));
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    add(NotificationStatusChanged(settings.authorizationStatus));
  }
}
