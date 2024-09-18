import 'package:dartz/dartz.dart';

import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../use_cases/login_use_case.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>>? login(LoginParams params);

  Future<Either<Failure, BlankEntity>>? logout();
}
