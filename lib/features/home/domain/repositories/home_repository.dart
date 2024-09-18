import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../login/domain/entities/user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUser();
}
