import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/blank_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../models/user_model.dart';

part 'auth_remote_data_source.dart';

abstract class AuthDataSource {
  Future<Either<Failure, UserModel>>? login(LoginParams params);

  Future<Either<Failure, BlankModel>>? logout();
}
