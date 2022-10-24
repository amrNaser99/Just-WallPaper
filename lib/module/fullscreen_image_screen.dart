import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/data/models/photos_model.dart';
import 'package:justwallpaper/shared/components/components.dart';
import 'package:justwallpaper/shared/styles/icon_broken.dart';
import '../home/presentation/cubit/wallpaper_cubit.dart';
import '../home/presentation/cubit/wallpaper_states.dart';

class FullScreenImageScreen extends StatefulWidget {
  final PhotosModel photo;

  FullScreenImageScreen({required this.photo});

  @override
  State<FullScreenImageScreen> createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WallPaperCubit, WallPaperStates>(
      listener: (context, state) {
        if (state is WallPaperDownloadInMediaFileLoadingState) {
          showSnackBar('Downloading...');
        }
      },
      builder: (context, state) {
        WallPaperCubit cubit = BlocProvider.of<WallPaperCubit>(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.6),
                                child: IconButton(
                                  icon: Icon(
                                    IconBroken.Heart,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    debugPrint('Favorite Clicked');
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),

                                  // Set Home Screen button
                                  ConditionalBuilder(
                                    condition: !cubit.isScreenWallPaperSet,
                                    builder: (BuildContext context) =>
                                        GestureDetector(
                                      onTap: () {
                                        cubit.setHomeWallPaper(widget.photo);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10.0),
                                            right: Radius.circular(10.0),
                                          ),
                                          color: Colors.transparent
                                              .withOpacity(0.8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              IconBroken.Image,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Set As Hone Wallpaper',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                // fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'janna',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    fallback: (BuildContext context) => Center(
                                        child: CircularProgressIndicator(color: Colors.white,)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Set Lock Screen button
                                  ConditionalBuilder(
                                    condition: !cubit.isLockWallPaperSet,
                                    builder: (BuildContext context) =>
                                        GestureDetector(
                                      onTap: () {
                                        cubit.setLockWallPaper(widget.photo);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10.0),
                                            right: Radius.circular(10.0),
                                          ),
                                          color: Colors.transparent
                                              .withOpacity(0.8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              IconBroken.Image_2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Set As Lock Wallpaper',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'janna',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    fallback: (BuildContext context) => Center(
                                        child: CircularProgressIndicator(color: Colors.white,)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Set Both Home and Lock Screen button
                                  ConditionalBuilder(
                                    condition: !cubit.isBothWallPaperSet,
                                    builder: (BuildContext context) =>
                                        GestureDetector(
                                      onTap: () {
                                        cubit.setBothWallPaper(
                                          widget.photo,
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10.0),
                                            right: Radius.circular(10.0),
                                          ),
                                          color: Colors.transparent
                                              .withOpacity(0.8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              IconBroken.Image_2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Set Both Wallpaper',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                // fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'janna',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    fallback: (BuildContext context) => Center(
                                        child: CircularProgressIndicator(color: Colors.white,)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Download Screen button
                                  ConditionalBuilder(
                                    condition: !cubit.isDownloaded,
                                    builder: (BuildContext context) =>
                                        GestureDetector(
                                      onTap: () {
                                        cubit.downloadInMediaFile(
                                            context, widget.photo);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10.0),
                                            right: Radius.circular(10.0),
                                          ),
                                          color: Colors.transparent
                                              .withOpacity(0.8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              IconBroken.Download,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Download In Media File',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                // fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'janna',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    fallback: (BuildContext context) =>
                                        Center(child: CircularProgressIndicator(color: Colors.white,)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.6),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    print('Share Clicked');
                                    cubit.shareWallPaperFile(
                                      widget.photo,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.photo.src!.portrait!),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.009,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
