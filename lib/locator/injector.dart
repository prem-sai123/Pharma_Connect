import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.config.dart';

final $sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({required String env}) async {
  await $sl.init(environment: env);

  $sl.registerSingleton(env, instanceName: 'env');
}

@module
abstract class ThirdPartyDependencies {
  @singleton
  Connectivity get connectivity => Connectivity();

  @singleton
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @singleton
  FirebaseFirestore get db => FirebaseFirestore.instance;
}
