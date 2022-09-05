import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/shared/components/components.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_states.dart';
import 'package:justwallpaper/shared/utils/size_config.dart';
import '../model/curated_model.dart';
import 'fullscreen_image_screen.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WallPaperCubit, WallPaperStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          WallPaperCubit cubit = BlocProvider.of(context);
          CuratedModel? model = cubit.curatedModel;
          ScrollController gridViewController = ScrollController();
          return Builder(builder: (context) {
            SizeConfig().init(context);
            return Scaffold(
              body: NestedScrollView(
                floatHeaderSlivers: true,
                physics: const BouncingScrollPhysics(),

                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    defaultAppBar(context, innerBoxIsScrolled),
                  ],
                body: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    ConditionalBuilder(
                      condition: model != null,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: LazyLoadScrollView(
                            onEndOfPage: () {
                              cubit.loadMoreWallPapers();
                            },
                            isLoading: cubit.isLoaded,
                            scrollDirection: Axis.vertical,
                            scrollOffset: 100,
                            child: GridView.builder(
                              controller: gridViewController,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.58,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsetsDirectional.all(10),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  print('index ${index}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenImageScreen(
                                        photo: model!.photos![index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    child: Image(
                                      height: model!.photos![index].height!
                                          .toDouble(),
                                      width: model.photos![index].width!
                                          .toDouble(),
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        model.photos![index].src!.portrait!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              itemCount: cubit.wallPaperList.length,
                              addAutomaticKeepAlives: true,
                              addRepaintBoundaries: true,
                            ),
                          ),
                        );
                      },
                      fallback: (BuildContext context) => Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
