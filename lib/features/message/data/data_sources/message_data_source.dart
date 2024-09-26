import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../domain/use_cases/receive_message_use_case.dart';
import '../models/message_model.dart';

part 'message_local_data_source.dart';
part 'message_remote_data_source.dart';

abstract class MessageDataSource {
  Future<Either<Failure, BlankModel>>? sendMessage(
    MessageModel message,
  );

  Stream<Either<Failure, List<MessageModel>>> receiveMessage(
    ReceiveMessageParams params,
  );
}
