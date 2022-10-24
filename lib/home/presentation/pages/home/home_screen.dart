import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/presentation/widgets/main_widget.dart';
import 'package:justwallpaper/home/presentation/widgets/search_layout.dart';
import 'package:justwallpaper/home/presentation/widgets/search_widget.dart';
import 'package:justwallpaper/shared/components/components.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_states.dart';
import '../../../../core/utils/size_config.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../module/fullscreen_image_screen.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/icon_broken.dart';
import '../../../data/models/curated_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController gridViewController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {
        if (tabController.indexIsChanging) {
          debugPrint('tabController.index ${tabController.index}');
          debugPrint('tabController count${tabController.length}');

          WallPaperCubit.get(this.context).changeTab(tabController.index);
        }
      });
    gridViewController =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true)
          ..addListener(() {
            if (gridViewController.position.pixels ==
                gridViewController.position.maxScrollExtent) {
              debugPrint('reached the bottom');
              WallPaperCubit.get(this.context).loadMoreWallPapers();
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WallPaperCubit, WallPaperStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          WallPaperCubit cubit = WallPaperCubit.get(context);
          CuratedModel? model = cubit.curatedModel;
          SizeConfig().init(context);
          return Scaffold(
            body: CustomScrollView(
              controller: gridViewController,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  floating: true,
                  backgroundColor: colorDark,
                  pinned: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Just',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'WallPaper',
                        style: TextStyle(
                            color: colorLight,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  actions: [
                    cubit.isSearchClicked
                        ? IconButton(
                            padding: EdgeInsetsDirectional.only(
                              end: 20,
                            ),
                            onPressed: () {
                              cubit.changeSearchbarClicked();
                            },
                            icon: Icon(
                              IconBroken.Arrow___Up_2,
                              color: colorLight,
                            ),
                          )
                        : IconButton(
                            padding: EdgeInsetsDirectional.only(
                              end: 20,
                            ),
                            onPressed: () {
                              cubit.changeSearchbarClicked();
                            },
                            icon: Icon(
                              IconBroken.Search,
                              color: colorLight,
                            ),
                          ),
                  ],
                ),
                if (cubit.isSearchClicked == true)
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SearchBarLayout(),
                      ],
                    ),
                  ),
                SliverList(
                  delegate:
                      SliverChildListDelegate(addAutomaticKeepAlives: true, [
                    Container(
                      child: TabBar(
                        controller: tabController,
                        tabs: cubit.tabs,
                        onTap: (index) {
                          debugPrint('index $index');
                        },
                        labelPadding: EdgeInsetsDirectional.only(
                          start: 10,
                          end: 10,
                        ),
                        physics: const BouncingScrollPhysics(),
                        indicatorColor: colorPrimary,
                      ),
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    ConditionalBuilder(
                      condition: cubit.curatedModel != null,
                      builder: (BuildContext context) {
                        return cubit.tabWidgets[cubit.currentIndex];
                      },
                      fallback: (BuildContext context) => Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          );
        });
  }
}
