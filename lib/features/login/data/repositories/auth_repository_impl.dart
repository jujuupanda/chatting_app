import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSourceImpl;

  AuthRepositoryImpl(this.authRemoteDataSourceImpl);

  @override
  Future<Either<Failure, UserEntity>>? login(
    LoginParams params,
  ) async {
    final userLoggedIn = await authRemoteDataSourceImpl.login(params);
    return userLoggedIn!.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, BlankEntity>>? logout() async {
    final userLogout = await authRemoteDataSourceImpl.logout();
    return userLogout!.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r);
      },
    );
  }
}
