import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUser();
}
