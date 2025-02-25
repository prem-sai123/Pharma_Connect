import 'package:dartz/dartz.dart';
import 'package:pharma_connect/model/failure.dart';

typedef AsyncValueOf<T> = Future<Either<Failure, T>>;
