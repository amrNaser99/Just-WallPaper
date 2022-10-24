import 'package:justwallpaper/home/data/models/photos_model.dart';

import '../../data/models/curated_model.dart';

class Curated {
  final int? page;
  final int? perPage;
  final List<PhotosModel>? photos;
  final int? totalResults;
  final String? nextPage;

  Curated({
    this.page,
    this.perPage,
    this.photos,
    this.totalResults,
    this.nextPage,
  });
}
