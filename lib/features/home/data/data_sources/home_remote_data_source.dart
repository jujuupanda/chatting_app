import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../login/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'home_data_source.dart';

class HomeRemoteDataSource extends HomeDataSource {
  final db = FirebaseFirestore.instance;
  final List<UserModel> emptyListUser = [];

  @override
  Future<Either<Failure, List<UserModel>>> getAllUserExceptLoggedIn() async {
    try {
      final email = SharedPrefs().getSomeString("email");
      final response = await db
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
