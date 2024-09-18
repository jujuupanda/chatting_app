import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_cases/use_case.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase implements FutureUseCase<BlankEntity, NoParams> {
  AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>?> call(NoParams noParams) async {
    return await repository.logout();
  }
}
