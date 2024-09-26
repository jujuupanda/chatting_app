part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

final class GetProfileSuccess extends ProfileState {
  final UserEntity profile;

  const GetProfileSuccess(this.profile);

  @override
  List<Object> get props => [profile];
}

final class GetProfileFailed extends ProfileState {
  final String message;

  const GetProfileFailed(this.message);

  @override
  List<Object> get props => [message];
}
