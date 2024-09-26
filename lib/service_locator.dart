import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/shared/bloc/auth/auth_bloc.dart';
import 'features/home/data/data_sources/home_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/use_cases/get_all_user_except_logged_in_use_case.dart';
import 'features/home/presentation/manager/user_home/user_home_bloc.dart';
import 'features/login/data/data_sources/auth_data_source.dart';
import 'features/login/data/repositories/auth_repository_impl.dart';
import 'features/login/domain/repositories/auth_repository.dart';
import 'features/login/domain/use_cases/login_use_case.dart';
import 'features/login/domain/use_cases/logout_use_case.dart';
import 'features/message/data/data_sources/message_data_source.dart';
import 'features/message/data/repositories/message_repository_impl.dart';
import 'features/message/domain/repositories/message_repository.dart';
import 'features/message/domain/use_cases/receive_message_use_case.dart';
import 'features/message/domain/use_cases/send_message_use_case.dart';
import 'features/message/presentation/manager/message_bloc.dart';
import 'features/profile/data/data_sources/profile_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/use_cases/get_profile_use_case.dart';
import 'features/profile/presentation/manager/profile_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() async {
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource());
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSource());
  getIt.registerLazySingleton<MessageRemoteDataSource>(
      () => MessageRemoteDataSource());
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(getIt<MessageRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetAllUserExceptLoggedInUseCase>(
    () => GetAllUserExceptLoggedInUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(getIt<MessageRepository>()),
  );
  getIt.registerLazySingleton<ReceiveMessageUseCase>(
    () => ReceiveMessageUseCase(getIt<MessageRepository>()),
  );
  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<ProfileRepository>()),
  );

  // Bloc
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
        loginUseCase: getIt<LoginUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
      ));
  getIt.registerFactory<UserHomeBloc>(() => UserHomeBloc(
        getAllUserUseCase: getIt<GetAllUserExceptLoggedInUseCase>(),
      ));
  getIt.registerFactory<MessageBloc>(() => MessageBloc(
        sendMessageUseCase: getIt<SendMessageUseCase>(),
        receiveMessageUseCase: getIt<ReceiveMessageUseCase>(),
      ));
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(
        getProfileUseCase: getIt<GetProfileUseCase>(),
      ));

  // Outside
  // SharedPreferences instance & Register
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Firebase
  // FirebaseFirestore
  // getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
}
