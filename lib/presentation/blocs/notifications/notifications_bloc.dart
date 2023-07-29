import 'package:bloc_exercises/domain/entities/push_message.dart';
import 'package:bloc_exercises/firebase_options.dart';
import 'package:bloc_exercises/infrastructure/extensions/remote_message_extensions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final Future<void> Function()? requestPermissionLocalNotifications;
  final Future<void> Function(
      {String? body,
      required int id,
      String? payload,
      String? title})? showLocalNotification;
  int pushNumberId = 0;

  NotificationsBloc(
      {this.requestPermissionLocalNotifications, this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationDelivered>(_notificationDelivered);

    _initialStatusCheck();
    _onForegroundMessage();
  }

  static initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _notificationDelivered(
      NotificationDelivered event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final pushMessage = message.mapToPushMessage();
    if (showLocalNotification != null) {
      showLocalNotification!(
        id: ++pushNumberId,
        body: pushMessage.body,
        title: pushMessage.title,
        payload: pushMessage.messageId,
      );
    }

    add(NotificationDelivered(pushMessage));
  }

  void _onForegroundMessage() =>
      FirebaseMessaging.onMessage.listen(handleRemoteMessage);

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

    if(requestPermissionLocalNotifications != null){
      await requestPermissionLocalNotifications!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String pushMessageId) {
    final existsMessage = state.notifications
        .any((element) => element.messageId == pushMessageId);
    if (!existsMessage) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}
