
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_cases/use_case.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../repositories/home_repository.dart';

class GetAllUserExceptLoggedInUseCase
    extends FutureUseCase<List<UserEntity>, NoParams> {
  HomeRepository repository;

  GetAllUserExceptLoggedInUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await repository.getAllUser();
  }
}