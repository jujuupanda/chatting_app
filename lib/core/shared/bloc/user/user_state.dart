part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
}
final class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}
final class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

final class GetAllUserSuccess extends UserState {
  @override
  List<Object> get props => [];
}

final class GetAllUserFailed extends UserState {
  final String message;

  const GetAllUserFailed(this.message);

  @override
  List<Object> get props => [message];
}


