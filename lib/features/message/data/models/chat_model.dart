import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.id,
    required super.senderId,
    required super.timeStamp,
    required super.lastMessage,
    required super.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final senderId = json["senderId"];
    final timeStamp = json["timeStamp"];
    final lastMessage = json["lastMessage"];
    final messages = json["messages"];

    final chatModel = ChatModel(
      id: id,
      senderId: senderId,
      timeStamp: timeStamp,
      lastMessage: lastMessage,
      messages: messages,
    );
    return chatModel;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "senderId": senderId,
        "timeStamp": timeStamp,
        "lastMessage": lastMessage,
      };
}
