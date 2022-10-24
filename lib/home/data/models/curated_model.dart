import 'package:justwallpaper/home/data/models/photos_model.dart';

import '../../domain/entities/curated.dart';

class CuratedModel extends Curated {
  CuratedModel({
    int? page,
    int? perPage,
    List<PhotosModel>? photos,
    String? nextPage,
    int? totalResults,
  }) : super(
          page: page,
          perPage: perPage,
          photos: photos,
          nextPage: nextPage,
          totalResults: totalResults,
        );

  factory CuratedModel.fromJson(Map<String, dynamic> json) {
    return CuratedModel(
      page: json['page'],
      perPage: json['per_page'],
      photos: (json['photos'] as List?)
          ?.map((e) => PhotosModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['total_results'] as int?,
      nextPage: json['next_page'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'per_page': perPage,
        'photos': photos?.map((e) => e.toJson()).toList(),
        'total_results': totalResults,
        'next_page': nextPage
      };
}
