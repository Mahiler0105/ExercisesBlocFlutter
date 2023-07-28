class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? payload;
  final String? imageUrl;

  PushMessage(
      {required this.messageId,
      required this.title,
      required this.body,
      required this.sentDate,
      this.payload,
      this.imageUrl});


  @override
  String toString() {
    return '''
    PushMessage -
      id: $messageId
      title: $title
      body: $body
      payload: $payload
      sentDate: $sentDate
      imageUrl: $imageUrl
    ''';
  }
}
