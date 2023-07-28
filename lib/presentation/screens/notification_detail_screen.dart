import 'package:bloc_exercises/domain/entities/push_message.dart';
import 'package:bloc_exercises/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String pushMessageId;

  const NotificationDetailScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final pushMessage =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles Push Notification"),
      ),
      body: pushMessage != null
          ? _NotificationDetailView(pushMessage: pushMessage)
          : const Text('Notificación no existe'),
    );
  }
}

class _NotificationDetailView extends StatelessWidget {
  final PushMessage pushMessage;

  const _NotificationDetailView({required this.pushMessage});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (pushMessage.imageUrl != null)
            Image.network(pushMessage.imageUrl!),
          const SizedBox(height: 20),
          Text(pushMessage.title, style: textTheme.titleMedium),
          Text(pushMessage.body, style: textTheme.bodyMedium),
          const Divider(),
          if (pushMessage.payload != null) Text(pushMessage.payload.toString()),
          Text(pushMessage.sentDate.toString()),
        ],
      ),
    );
  }
}
