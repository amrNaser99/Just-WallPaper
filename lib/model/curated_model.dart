import 'package:flutter/material.dart';

class CuratedModel {

  final int? page;
  final int? perPage;
  final List<Photos>? photos;
  final int? totalResults;
  final String? nextPage;

  CuratedModel({
    this.page,
    this.perPage,
    this.photos,
    this.totalResults,
    this.nextPage,
  });

  CuratedModel.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        perPage = json['per_page'] as int?,
        photos = (json['photos'] as List?)?.map((dynamic e) => Photos.fromJson(e as Map<String,dynamic>)).toList(),
        totalResults = json['total_results'] as int?,
        nextPage = json['next_page'] as String?;

  Map<String, dynamic> toJson() => {
    'page' : page,
    'per_page' : perPage,
    'photos' : photos?.map((e) => e.toJson()).toList(),
    'total_results' : totalResults,
    'next_page' : nextPage
  };
}

class Photos {
  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final Src? src;
  final bool? liked;
  final String? alt;

  Photos({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  Photos.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        width = json['width'] as int?,
        height = json['height'] as int?,
        url = json['url'] as String?,
        photographer = json['photographer'] as String?,
        photographerUrl = json['photographer_url'] as String?,
        photographerId = json['photographer_id'] as int?,
        avgColor = json['avg_color'] as String?,
        src = (json['src'] as Map<String,dynamic>?) != null ? Src.fromJson(json['src'] as Map<String,dynamic>) : null,
        liked = json['liked'] as bool?,
        alt = json['alt'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'width' : width,
    'height' : height,
    'url' : url,
    'photographer' : photographer,
    'photographer_url' : photographerUrl,
    'photographer_id' : photographerId,
    'avg_color' : avgColor,
    'src' : src?.toJson(),
    'liked' : liked,
    'alt' : alt
  };
}

class Src {
  final String? original;
  final String? large2x;
  final String? large;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? landscape;
  final String? tiny;

  Src({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  Src.fromJson(Map<String, dynamic> json)
      : original = json['original'] as String?,
        large2x = json['large2x'] as String?,
        large = json['large'] as String?,
        medium = json['medium'] as String?,
        small = json['small'] as String?,
        portrait = json['portrait'] as String?,
        landscape = json['landscape'] as String?,
        tiny = json['tiny'] as String?;

  Map<String, dynamic> toJson() => {
    'original' : original,
    'large2x' : large2x,
    'large' : large,
    'medium' : medium,
    'small' : small,
    'portrait' : portrait,
    'landscape' : landscape,
    'tiny' : tiny
  };
}