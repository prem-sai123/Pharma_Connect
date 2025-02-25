import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharma_connect/pharma_connect_app.dart';

import 'locator/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  await _initInjector();
  runApp(PharmaConnectApp());
}

Future<void> _initInjector() async {
  await configureDependencies(env: Environment.prod);
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp();
}