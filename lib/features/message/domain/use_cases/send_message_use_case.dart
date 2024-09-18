import 'package:dartz/dartz.dart';

import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../data/models/message_model.dart';
import '../repositories/message_repository.dart';

class SendMessageUseCase extends FutureUseCase<BlankEntity, MessageModel> {
  MessageRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>?> call(MessageModel params) async {
    return await repository.sendMessages(params);
  }
}
