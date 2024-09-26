import 'package:dartz/dartz.dart';

import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/message_model.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';
import '../use_cases/receive_message_use_case.dart';

abstract class MessageRepository {
  Future<Either<Failure, BlankEntity>>? sendMessages(
    MessageModel message,
  );

  Stream<Either<Failure, List<MessageEntity>>> receiveMessages(
    ReceiveMessageParams params
  );
}
