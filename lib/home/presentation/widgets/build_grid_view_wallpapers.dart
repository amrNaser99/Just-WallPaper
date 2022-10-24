import 'package:flutter/material.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/home/presentation/widgets/wallpaper_item.dart';

import '../../../module/fullscreen_image_screen.dart';

class buildGridViewWallpaper extends StatelessWidget {
  final List wallPaperList;

  const buildGridViewWallpaper({
    Key? key,
    required this.wallPaperList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsetsDirectional.all(10),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          print('index ${index}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImageScreen(
                photo: wallPaperList[index],
              ),
            ),
          );
        },
        child: WallpaperItem(photo: wallPaperList[index]),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      itemCount: wallPaperList.length,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
    );
  }
}
