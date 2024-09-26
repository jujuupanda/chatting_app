import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_cases/use_case.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';

class ReceiveMessageUseCase
    extends StreamUseCase<List<MessageEntity>, ReceiveMessageParams> {
  MessageRepository repository;

  ReceiveMessageUseCase(this.repository);

  @override
  Stream<Either<Failure, List<MessageEntity>>?> call(params) {
    return repository.receiveMessages(params);
  }
}

class ReceiveMessageParams extends Equatable {
  final String senderId;
  final String receiverId;

  const ReceiveMessageParams(
    this.senderId,
    this.receiverId,
  );

  @override
  List<Object?> get props => [senderId, receiverId];
}
