part of 'user_home_bloc.dart';

sealed class UserHomeEvent extends Equatable {
  const UserHomeEvent();
}

final class UserHomeInitialEvent extends UserHomeEvent {
  @override
  List<Object?> get props => [];
}

final class GetAllUserExceptLoginEvent extends UserHomeEvent {

  @override
  List<Object?> get props => [];
}
