part of 'user_home_bloc.dart';

sealed class UserHomeState extends Equatable {
  const UserHomeState();
}

final class UserHomeInitialState extends UserHomeState {
  @override
  List<Object> get props => [];
}

final class UserHomeLoadingState extends UserHomeState {
  @override
  List<Object> get props => [];
}

final class GetAllUserSuccess extends UserHomeState {
  final List<UserEntity> listUserExceptLoggedIn;

  const GetAllUserSuccess(this.listUserExceptLoggedIn);

  @override
  List<Object> get props => [listUserExceptLoggedIn];
}

final class GetAllUserFailed extends UserHomeState {
  final String message;

  const GetAllUserFailed(this.message);

  @override
  List<Object> get props => [message];
}
