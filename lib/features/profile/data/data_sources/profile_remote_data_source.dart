part of 'profile_data_source.dart';

class ProfileRemoteDataSource extends ProfileDataSource {
  final firestoreDB = FirebaseService().firestoreDB;

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final email = SharedPrefs().getSomeString("email");
      final response = await firestoreDB
          .collection("users")
          .where("email", isEqualTo: email)
          .get();
      if (response.docs.isNotEmpty) {
        final result = UserModel.fromJson(response.docs.first.data());
        return Right(result);
      } else {
        return Left(
          ServerFailure("Terjadi kesalahan saat mendapatkan info user"),
        );
      }
    } catch (e) {
      return Left(
        ServerFailure("Terjadi kesalahan saat mendapatkan info user"),
      );
    }
  }
}
