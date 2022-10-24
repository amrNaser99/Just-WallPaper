import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/data/models/curated_model.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_states.dart';
import 'package:justwallpaper/home/presentation/widgets/build_grid_view_wallpapers.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../module/fullscreen_image_screen.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallPaperCubit, WallPaperStates>(
      builder: (context, state) {
        WallPaperCubit cubit = WallPaperCubit.get(context);
        CuratedModel model = cubit.curatedModel!;
        return Container(
          child: LazyLoadScrollView(
            onEndOfPage: () {
              cubit.loadMoreWallPapers();
            },
            isLoading: cubit.isLoaded,
            scrollDirection: Axis.vertical,
            scrollOffset: 100,
            child: buildGridViewWallpaper(
              wallPaperList: model.photos!,
            ),
          ),
        );
      },
    );
  }
}
