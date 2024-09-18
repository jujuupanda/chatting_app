part of 'message_data_source.dart';

class MessageRemoteDataSource extends MessageDataSource {
  final _db = FirebaseFirestore.instance;

  String _getChatRoomId(String senderId, String receiverId) {
    List<String> sortedId = [senderId, receiverId]..sort();
    final chatRoomId = sortedId.join("_");
    final bytes = utf8.encode(chatRoomId);
    final chatRoomIdHashed = md5.convert(bytes);
    return chatRoomIdHashed.toString();
  }

  @override
  Future<Either<Failure, BlankModel>>? sendMessage(
    MessageModel message,
  ) async {
    try {
      final chatRoomId = _getChatRoomId(message.senderId, message.receiverId);
      await _db
          .collection("chat")
          .doc(chatRoomId)
          .collection("messages")
          .add(message.toJson())
          .then(
        (value) {
          _db
              .collection("chat")
              .doc(chatRoomId)
              .collection("messages")
              .doc(value.id)
              .update(
            {
              "id": value.id,
            },
          );
        },
      );
      return Right(BlankModel());
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat mengirim pesan"));
    }
  }

  @override
  Stream<Either<Failure, List<MessageModel>>> receiveMessage(
    ReceiveMessageParams params,
  ) {
    final chatRoomId = _getChatRoomId(params.senderId, params.receiverId);
    return _db
        .collection("chat")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map(
      (snapshot) {
        try {
          final messages = snapshot.docs
              .map(
                (e) => MessageModel.fromJson(e.data()),
              )
              .toList();
          return Right(messages);
        } catch (e) {
          return Left(
              ServerFailure("Terjadi kesalahan saat mendapatkan pesan"));
        }
      },
    );
  }
}
