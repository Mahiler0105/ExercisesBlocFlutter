import 'package:bloc_exercises/config/local_notifications.dart';
import 'package:bloc_exercises/config/theme/app_theme.dart';
import 'package:bloc_exercises/infrastructure/extensions/remote_message_extensions.dart';
import 'package:bloc_exercises/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await LocalNotifications.initializeLocalNotifications();
  await NotificationsBloc.initializeFCM();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => NotificationsBloc(
      requestPermissionLocalNotifications: LocalNotifications.requestPermissionLocalNotifications,
      showLocalNotification: LocalNotifications.showLocalNotification,
    ), lazy: false)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      builder: (buildContext, widget) =>
          HandleNotificationInteractions(child: widget!),
    );
  }
}

class HandleNotificationInteractions extends StatefulWidget {
  final Widget child;

  const HandleNotificationInteractions({super.key, required this.child});

  @override
  State<HandleNotificationInteractions> createState() =>
      _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState
    extends State<HandleNotificationInteractions> {

  Future<void> setupInteractedMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    context.read<NotificationsBloc>().handleRemoteMessage(message, false);
    final messageId = message.getValidMessageId();
    appRouter.push("/notifications/$messageId");
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
