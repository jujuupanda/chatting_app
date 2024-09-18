part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class IsLoginEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
