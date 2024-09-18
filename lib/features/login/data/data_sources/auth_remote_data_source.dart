part of 'auth_data_source.dart';

class AuthRemoteDataSource extends AuthDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, UserModel>>? login(LoginParams params) async {
    try {
      final result = await db
          .collection("logins")
          .where(
            "email",
            isEqualTo: params.email,
          )
          .get();

      if (result.docs.isNotEmpty) {
        final matchedUser = result.docs.first;
        if (matchedUser.data()["password"] == params.password) {
          final getUser = await db
              .collection("users")
              .where("email", isEqualTo: params.email)
              .get();
          final user = UserModel.fromJson(getUser.docs.first.data());
          SharedPrefs().saveToken(user.id);
          SharedPrefs().saveSomeString("email", user.email);
          return Right(user);
        } else {
          return Left(ServerFailure("Password salah"));
        }
      } else {
        return Left(ServerFailure("Email tidak terdaftar"));
      }
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat login"));
    }
  }

  @override
  Future<Either<Failure, BlankModel>>? logout() async {
    bool logoutSuccess = SharedPrefs().removeToken();
    if (logoutSuccess == true) {
      return Right(BlankModel());
    } else {
      return Left(ServerFailure("Gagal melakukan logout"));
    }
  }
}
