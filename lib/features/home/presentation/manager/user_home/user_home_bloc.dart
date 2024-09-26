import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../../../../core/shared/entity/user_entity.dart';
import '../../../domain/use_cases/get_all_user_except_logged_in_use_case.dart';

part 'user_home_event.dart';

part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  GetAllUserExceptLoggedInUseCase getAllUserUseCase;

  UserHomeBloc({required this.getAllUserUseCase})
      : super(UserHomeInitialState()) {
    on<UserHomeInitialEvent>((event, emit) {});
    on<GetAllUserExceptLoginEvent>(getAllUser);
  }

  getAllUser(
      GetAllUserExceptLoginEvent event, Emitter<UserHomeState> emit) async {
    emit(UserHomeLoadingState());
    final result = await getAllUserUseCase.call(NoParams());
    result.fold(
      (l) {
        if (l is ServerFailure) {
          emit(GetAllUserFailed(l.message));
        }
      },
      (r) {
        emit(GetAllUserSuccess(r));
      },
    );
  }
}
