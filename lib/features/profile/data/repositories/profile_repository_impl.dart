import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    final getProfileLoggedIn = await remoteDataSource.getProfile();
    return getProfileLoggedIn.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
