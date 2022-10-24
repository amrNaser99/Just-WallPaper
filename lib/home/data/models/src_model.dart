import 'package:justwallpaper/home/domain/entities/src.dart';

class SrcModel extends Src {
  SrcModel({
    String? original,
    String? large2X,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) : super(
          original: original,
          large2x: large2X,
          large: large,
          medium: medium,
          small: small,
          portrait: portrait,
          landscape: landscape,
          tiny: tiny,
        );

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(
      original: json['original'] as String?,
      large2X: json['large2x'] as String?,
      large: json['large'] as String?,
      medium: json['medium'] as String?,
      small: json['small'] as String?,
      portrait: json['portrait'] as String?,
      landscape: json['landscape'] as String?,
      tiny: json['tiny'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'original': original,
        'large2x': large2x,
        'large': large,
        'medium': medium,
        'small': small,
        'portrait': portrait,
        'landscape': landscape,
        'tiny': tiny
      };
}
