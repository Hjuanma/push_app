import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../domain/domain.dart';
import '../../../firebase_options.dart';

part 'notications_event.dart';
part 'notications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NoticationsBloc extends Bloc<NoticationsEvent, NoticationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NoticationsBloc() : super(const NoticationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessgeRecieived);

    //verifica el estado de las notificaciones
    _initialStatusCheck();

    //listener para las notificaciones en foregroun
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NoticationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onPushMessgeRecieived(
      NotificationReceived event, Emitter<NoticationsState> emit) {
    emit(state.copyWith(
        notifications: [event.notification, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print("Token ===== $token");
  }

  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? "",
        title: message.notification!.title ?? "",
        body: message.notification!.body ?? "",
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
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
    _getFCMToken();
  }

  PushMessage? getMessageById(String pushMessageId){
    final exist = state.notifications.any((element) => element.messageId == pushMessageId,);

    if(!exist) return null;

    return state.notifications.firstWhere((element) => element.messageId == pushMessageId);
    
  }
}
