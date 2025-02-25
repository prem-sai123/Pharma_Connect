// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../features/home_page/data/home_page_repo.dart' as _i594;
import '../features/home_page/data/home_page_repo_impl.dart' as _i830;
import '../features/home_page/presentation/bloc/sample_drugs/sample_drugs_cubit.dart'
    as _i989;
import 'injector.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyDependencies = _$ThirdPartyDependencies();
    gh.singleton<_i895.Connectivity>(() => thirdPartyDependencies.connectivity);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => thirdPartyDependencies.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i974.FirebaseFirestore>(() => thirdPartyDependencies.db);
    gh.lazySingleton<_i594.HomePageRepo>(
      () => _i830.HomePageRepoImpl(db: gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i989.SampleDrugsCubit>(
      () => _i989.SampleDrugsCubit(gh<_i594.HomePageRepo>()),
    );
    return this;
  }
}

class _$ThirdPartyDependencies extends _i811.ThirdPartyDependencies {}
