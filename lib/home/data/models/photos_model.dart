import 'package:justwallpaper/home/data/models/src_model.dart';
import 'package:justwallpaper/home/domain/entities/photos.dart';

class PhotosModel extends Photos {
  PhotosModel({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    SrcModel? src,
    bool? liked,
    String? alt,
  }) : super(
          id: id,
          width: width,
          height: height,
          url: url,
          photographer: photographer,
          photographerUrl: photographerUrl,
          photographerId: photographerId,
          avgColor: avgColor,
          src: src,
          liked: liked,
          alt: alt,
        );

  factory PhotosModel.fromJson(Map<String, dynamic> json) {
    return PhotosModel(
      id: json['id'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      url: json['url'] as String?,
      photographer: json['photographer'] as String?,
      photographerUrl: json['photographer_url'] as String?,
      photographerId: json['photographer_id'] as int?,
      avgColor: json['avg_color'] as String?,
      src: (json['src'] as Map<String, dynamic>?) != null
          ? SrcModel.fromJson(json['src'] as Map<String, dynamic>)
          : null,
      liked: json['liked'] as bool?,
      alt: json['alt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'avg_color': avgColor,
        'src': src?.toJson(),
        'liked': liked,
        'alt': alt
      };
}
