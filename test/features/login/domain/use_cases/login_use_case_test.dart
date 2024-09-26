import 'package:chatting_app/core/shared/entity/user_entity.dart';
import 'package:chatting_app/features/login/domain/repositories/auth_repository.dart';
import 'package:chatting_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  final tUserEntity = UserEntity(
    id: "AmjWrJJOOW763JQVNqOD",
    email: "myemail@gmail.com",
    image: "myimage",
    phone: "myphone", firstName: '', middleName: '', lastName: '', information: '',
  );
  const tLogin = LoginParams(email: "myemail@gmail.com", password: "1234");
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  test("login berhasil", () async {
    // arrange
    when(mockAuthRepository.login(tLogin))
        .thenAnswer((_) async => Right(tUserEntity));
    // act
    final result = await useCase.call(tLogin);
    // assert
    expect(result, equals(Right(tUserEntity)));

    verify((_) => mockAuthRepository.login(tLogin));
  });
}
