import 'package:flutter/material.dart';
import 'package:justwallpaper/home/data/models/curated_model.dart';
import 'package:justwallpaper/home/data/models/photos_model.dart';

class WallpaperItem extends StatelessWidget {
  final PhotosModel photo ;
  const WallpaperItem({Key? key,required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        child: Image(
          height: photo.height!.toDouble(),
          width: photo.width!.toDouble(),
          fit: BoxFit.cover,
          image: NetworkImage(
            photo.src!.portrait!,
          ),
        ),
      ),
    );
  }
}
