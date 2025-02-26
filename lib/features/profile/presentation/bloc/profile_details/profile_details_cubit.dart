import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/features/home_page/data/home_page_repo.dart';
import 'package:pharma_connect/features/profile/model/user_details.dart';
import 'package:pharma_connect/locator/injector.dart';
import 'package:pharma_connect/model/failure.dart';

part 'profile_details_cubit.freezed.dart';

@injectable
class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  ProfileDetailsCubit(this.repo) : super(ProfileDetailsState.initial());

  final HomePageRepo repo;

  static ProfileDetailsCubit get() => $sl.get<ProfileDetailsCubit>();
  void fetchDetails() async {
    await Future.delayed(Duration(milliseconds: 10));
    emit(_Loading());
    final res = await repo.fetchUser();
    emit(_Success(res));
  }

  void updateDetails(UserDetails details) async {
    emit(_Loading());
    final res = await repo.addOrUpdateUser(details);
    emit(res.fold(_Failure.new, (r) => _Success(details)));
  }
}

@freezed
class ProfileDetailsState with _$ProfileDetailsState {
  const factory ProfileDetailsState.initial() = _Initial;
  const factory ProfileDetailsState.loading() = _Loading;
  const factory ProfileDetailsState.success(UserDetails? details) = _Success;
  const factory ProfileDetailsState.failure(Failure failure) = _Failure;
}
