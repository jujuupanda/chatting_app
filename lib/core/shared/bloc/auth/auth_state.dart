part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginSuccess extends AuthState {
  final UserEntity user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class LoginFailed extends AuthState {
  final String message;

  const LoginFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class LoggedIn extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoggedOut extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LogoutSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LogoutFailed extends AuthState {
  final String message;

  const LogoutFailed(this.message);

  @override
  List<Object?> get props => [message];
}
