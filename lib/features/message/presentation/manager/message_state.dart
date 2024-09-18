part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();
}

final class MessageInitialState extends MessageState {
  @override
  List<Object> get props => [];

}final class MessageLoadingState extends MessageState {
  @override
  List<Object> get props => [];
}

final class SendMessageSuccess extends MessageState {
  @override
  List<Object> get props => [];
}

final class SendMessageFailed extends MessageState {
  @override
  List<Object> get props => [];
}

final class ReceiveMessageSuccess extends MessageState {
  final List<MessageEntity> messages;

  const ReceiveMessageSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

final class ReceiveMessageFailed extends MessageState {
  @override
  List<Object> get props => [];
}
