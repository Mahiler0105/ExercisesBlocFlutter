import 'dart:io';

import 'package:bloc_exercises/domain/entities/push_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

extension RemoteMessageExtensions on RemoteMessage {
  String getValidMessageId() {
    return messageId?.replaceAll(':', '').replaceAll('%', '') ?? '';
  }

  PushMessage mapToPushMessage() => PushMessage(
        messageId: getValidMessageId(),
        title: notification!.title ?? '',
        body: notification!.body ?? '',
        sentDate: sentTime ?? DateTime.now(),
        payload: data,
        imageUrl: Platform.isAndroid
            ? notification!.android?.imageUrl
            : notification!.apple?.imageUrl,
      );
}
