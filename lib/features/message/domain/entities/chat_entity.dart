import 'message_entity.dart';

class ChatEntity {
  final String id;
  final String senderId;
  final String lastMessage;
  final String timeStamp;
  final List<MessageEntity> messages;

  ChatEntity({
    required this.id,
    required this.senderId,
    required this.lastMessage,
    required this.timeStamp,
    required this.messages,
  });
}
