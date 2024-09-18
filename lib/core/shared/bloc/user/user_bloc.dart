import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserInitialEvent>((event, emit) {});
    on<GetAllUserExceptLoggedIn>(getAllUser);
  }

  getAllUser(GetAllUserExceptLoggedIn event, Emitter<UserState> emit) {
    emit(UserLoadingState());
    try {} catch (e) {
      throw Exception(e);
    }
  }
}
