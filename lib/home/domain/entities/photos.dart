import 'package:justwallpaper/home/data/models/src_model.dart';

import '../../data/models/curated_model.dart';

class Photos {

  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final SrcModel? src;
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

}