import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/presentation/widgets/build_grid_view_wallpapers.dart';
import 'package:justwallpaper/home/presentation/widgets/wallpaper_item.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../module/fullscreen_image_screen.dart';
import '../../data/models/curated_model.dart';
import '../../data/models/photos_model.dart';
import '../cubit/wallpaper_cubit.dart';
import '../cubit/wallpaper_states.dart';

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallPaperCubit, WallPaperStates>(
      builder: (context, state) {
        WallPaperCubit cubit = WallPaperCubit.get(context);
        List<PhotosModel> photos = cubit.favouriteWallpaperList;
        return Container(
          child: ConditionalBuilder(
            condition: photos.isNotEmpty,
            builder: (BuildContext context) {
              return buildGridViewWallpaper(
                wallPaperList: photos,
              );
            },
            fallback: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Text(
                    'No Favourite WallPapers,yet',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
