import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../login/data/models/user_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, List<UserModel>>> getAllUserExceptLoggedIn();
}
