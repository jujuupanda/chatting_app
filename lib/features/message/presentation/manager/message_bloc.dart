import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message_model.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/use_cases/receive_message_use_case.dart';
import '../../domain/use_cases/send_message_use_case.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  SendMessageUseCase sendMessageUseCase;
  ReceiveMessageUseCase receiveMessageUseCase;

  MessageBloc({
    required this.sendMessageUseCase,
    required this.receiveMessageUseCase,
  }) : super(MessageInitialState()) {
    on<MessageInitialEvent>(messageInitialEvent);
    on<SendMessage>(sendMessage);
    on<ReceiveMessage>(receiveMessage);
  }

  messageInitialEvent(MessageInitialEvent event, Emitter<MessageState> emit) {
    emit(MessageInitialState());
  }

  sendMessage(SendMessage event, Emitter<MessageState> emit) async {
    emit(MessageLoadingState());
    final resultSendMessage = await sendMessageUseCase.call(
      MessageModel(
        id: event.id,
        senderId: event.senderId,
        receiverId: event.receiverId,
        content: event.content,
        timeStamp: event.timeStamp,
      ),
    );
    resultSendMessage?.fold(
      (l) {
        emit(SendMessageFailed());
      },
      (r) {
        emit(SendMessageSuccess());
      },
    );
  }

  receiveMessage(ReceiveMessage event, Emitter<MessageState> emit) async {
    emit(MessageLoadingState());
    final receiveMessage = receiveMessageUseCase.call(
      ReceiveMessageParams(
        event.senderId,
        event.receiverId,
      ),
    );

    try {
      await for (var either in receiveMessage) {
        either?.fold(
          (failure) {
            emit(ReceiveMessageFailed());
          },
          (message) {
            emit(ReceiveMessageSuccess(message));
          },
        );
      }
    } catch (e) {
      emit(ReceiveMessageFailed());
    }
  }
}
