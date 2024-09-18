import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/message_repository.dart';
import '../../domain/use_cases/receive_message_use_case.dart';
import '../data_sources/message_data_source.dart';
import '../models/message_model.dart';

class MessageRepositoryImpl extends MessageRepository {
  MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BlankEntity>>? sendMessages(
    MessageModel message,
  ) async {
    final sendMessage = await remoteDataSource.sendMessage(message);
    return sendMessage!.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> receiveMessages(
    ReceiveMessageParams params,
  )  {
    return remoteDataSource.receiveMessage(params);
  }
}
