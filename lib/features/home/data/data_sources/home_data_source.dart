import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../../core/shared/model/user_model.dart';

part 'home_remote_data_source.dart';

abstract class HomeDataSource {
  Future<Either<Failure, List<UserModel>>> getAllUserExceptLoggedIn();
}
