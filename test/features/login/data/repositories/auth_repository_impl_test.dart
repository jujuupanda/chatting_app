import 'package:chatting_app/core/error/failure.dart';
import 'package:chatting_app/features/login/data/data_sources/auth_data_source.dart';
import 'package:chatting_app/core/shared/model/user_model.dart';
import 'package:chatting_app/features/login/data/repositories/auth_repository_impl.dart';
import 'package:chatting_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRemoteDataSourceImpl extends Mock
    implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSourceImpl mockAuthRemoteDataSourceImpl;
  const tLogin = LoginParams(email: "myemail@gmail.com", password: "1234");
  final userModel = UserModel(
      id: "AmjWrJJOOW763JQVNqOD",
      email: "myemail@gmail.com",
      image: "myimage",
      phone: "myphone", firstName: '', middleName: '', lastName: '', information: '');
  setUp(() {
    mockAuthRemoteDataSourceImpl = MockAuthRemoteDataSourceImpl();
    repository = AuthRepositoryImpl( mockAuthRemoteDataSourceImpl);
  });

  test("login berhasil", () async {
    ///arrange
    when(mockAuthRemoteDataSourceImpl.login(tLogin))
        .thenAnswer((_) async => Right(userModel));

    ///act
    final result = await repository.login(tLogin);

    ///assert
    expect(result, equals(Right(userModel)));
  });

  test("login gagal email password kosong", () async {
    ///arrange
    when(mockAuthRemoteDataSourceImpl.login(const LoginParams(email: "", password: "")))
        .thenAnswer((_) async => Left(ServerFailure("")));

    ///act
    final result = await repository.login(const LoginParams(email: "", password: ""));

    ///assert
    expect(result, equals(Left(ServerFailure(""))));
  });
}
