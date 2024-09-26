import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/entity/user_entity.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase extends FutureUseCase<UserEntity, NoParams> {
  ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>?> call(NoParams params) async {
    return await repository.getProfile();
  }
}
