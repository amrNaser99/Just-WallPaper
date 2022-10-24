import 'package:flutter/material.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/home/presentation/widgets/build_grid_view_wallpapers.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildGridViewWallpaper(wallPaperList: WallPaperCubit.get(context).searchWallpaperList);
  }
}
