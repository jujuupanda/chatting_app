import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/user_entity.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../domain/use_cases/get_profile_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase})
      : super(ProfileInitialState()) {
    on<ProfileInitialEvent>(profileInitialEvent);
    on<GetProfile>(getProfile);
  }

  profileInitialEvent(ProfileInitialEvent event, Emitter<ProfileState> emit) {
    emit(ProfileInitialState());
  }

  getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    final result = await getProfileUseCase.call(NoParams());
    return result!.fold(
      (l) {
        if (l is ServerFailure) {
          emit(GetProfileFailed(l.message));
        }
      },
      (r) => emit(GetProfileSuccess(r)),
    );
  }
}
