part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();
}

final class SendMessage extends MessageEvent {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String timeStamp;

  const SendMessage(
    this.id,
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  );

  @override
  List<Object?> get props => [id, senderId, receiverId, content, timeStamp];
}

final class MessageInitialEvent extends MessageEvent {
  @override
  List<Object?> get props => [];
}

final class ReceiveMessage extends MessageEvent {
  final String senderId;
  final String receiverId;

  const ReceiveMessage(this.senderId, this.receiverId);

  @override
  List<Object?> get props => [senderId, receiverId];
}
