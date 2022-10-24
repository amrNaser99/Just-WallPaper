import 'package:dartz/dartz.dart';

abstract class WallpaperRepository {
  Future<Either<String, dynamic>> getCurated({
    int? page,
    int? perPage,
  });
}