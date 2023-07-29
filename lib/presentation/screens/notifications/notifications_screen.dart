import 'package:bloc_exercises/domain/entities/push_message.dart';
import 'package:bloc_exercises/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((NotificationsBloc bloc) =>
            Text("Status: ${bloc.state.status.name}")),
        actions: [
          IconButton(
              onPressed: () =>
                  context.read<NotificationsBloc>().requestPermission(),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;
    if (notifications.isEmpty) {
      return const Center(child: Text('No hay notificaiones disponibles'));
    }

    return ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (buildContext, index) {
          final notification = notifications[index];
          return _NotificationItem(pushMessage: notification);
        });
  }
}

class _NotificationItem extends StatelessWidget {
  final PushMessage pushMessage;

  const _NotificationItem({required this.pushMessage});

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.titleMedium;
    final bodyTheme = Theme.of(context).textTheme.bodyMedium;

    return ListTile(
      title: Text(pushMessage.title, style: titleTheme),
      subtitle: Text(pushMessage.body, style: bodyTheme),
      leading: pushMessage.imageUrl != null
          ? Image.network(
              pushMessage.imageUrl!,
              width: 100,
              height: 60,
            )
          : null,
      onTap: () => context.push("/notifications/${pushMessage.messageId}"),
    );
  }
}
