part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class UserInitialEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

final class GetAllUserExceptLoggedIn extends UserEvent {
  @override
  List<Object?> get props => [];
}
