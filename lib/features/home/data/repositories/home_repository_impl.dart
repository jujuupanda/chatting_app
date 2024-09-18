import '../../../../core/error/failure.dart';
import '../../../login/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUser() async {
    final getALlUserExceptLoggedIn =
        await remoteDataSource.getAllUserExceptLoggedIn();
    return getALlUserExceptLoggedIn.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r);
      },
    );
  }
}
