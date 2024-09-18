import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.timeStamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final senderId = json["senderId"];
    final receiverId = json["receiverId"];
    final content = json["content"];
    final timeStamp = json["timeStamp"];

    final messageModel = MessageModel(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      timeStamp: timeStamp,
    );
    return messageModel;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "senderId": senderId,
        "receiverId": receiverId,
        "content": content,
        "timeStamp": timeStamp,
      };
}
