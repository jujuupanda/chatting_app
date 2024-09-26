import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../entity/user_entity.dart';
import '../../../../features/login/domain/use_cases/login_use_case.dart';
import '../../../../features/login/domain/use_cases/logout_use_case.dart';
import '../../../use_cases/use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<IsLoginEvent>(isLogin);
    on<LoginEvent>(onLogin);
    on<LogoutEvent>(onLogout);
  }

  isLogin(IsLoginEvent event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    final userToken = SharedPrefs().getToken();
    if (userToken != null) {
      emit(LoggedIn());
    } else {
      emit(LoggedOut());
    }
  }

  onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase
        .call(LoginParams(email: event.email, password: event.password));
    result?.fold(
      (l) {
        if (l is ServerFailure) {
          emit(LoginFailed(l.message));
        }
      },
      (r) {
        emit(LoginSuccess(r));
      },
    );
  }

  onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.call(NoParams());
    result?.fold(
      (l) {
        if (l is ServerFailure) {
          emit(LogoutFailed(l.message));
        }
      },
      (r) {
        emit(LogoutSuccess());
      },
    );
  }
// onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
//   emit(AuthLoading());
//   final result = await useCase.repository.logout();
//   result?.fold(
//     (l) {
//       if (l is ServerFailure) {
//         emit(LogoutFailed(l.message));
//       }
//     },
//     (r) {
//       emit(LogoutSuccess());
//     },
//   );
// }
}
