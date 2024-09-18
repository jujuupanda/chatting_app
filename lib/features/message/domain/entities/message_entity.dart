class MessageEntity {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String timeStamp;

  MessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timeStamp,
  });
}
