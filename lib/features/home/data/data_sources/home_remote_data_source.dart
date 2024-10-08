part of 'home_data_source.dart';

class HomeRemoteDataSource extends HomeDataSource {
  final firestoreDB = FirebaseService().firestoreDB;
  final List<UserModel> emptyListUser = [];

  @override
  Future<Either<Failure, List<UserModel>>> getAllUserExceptLoggedIn() async {
    try {
      final email = SharedPrefs().getSomeString("email");
      final response = await firestoreDB
          .collection("users")
          .where("email", isNotEqualTo: email)
          .get();
      if (response.docs.isNotEmpty) {
        final result = response.docs
            .map(
              (e) => UserModel.fromJson(e.data()),
            )
            .toList();
        return Right(result);
      } else {
        return Right(emptyListUser);
      }
    } catch (e) {
      return Left(
        ServerFailure("Terjadi kesalahan saat mendapatkan info user"),
      );
    }
  }
}
