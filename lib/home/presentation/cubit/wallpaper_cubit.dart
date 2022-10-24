import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:justwallpaper/home/data/models/photos_model.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_states.dart';
import 'package:justwallpaper/home/presentation/widgets/favourite_widget.dart';
import 'package:justwallpaper/home/presentation/widgets/search_widget.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

import '../../../core/app_const.dart';
import '../../../core/services/remote/dio_helper.dart';
import '../../data/models/curated_model.dart';
import '../widgets/collection_widget.dart';
import '../widgets/main_widget.dart';

class WallPaperCubit extends Cubit<WallPaperStates> {
  WallPaperCubit() : super(WallPaperInitialState());

  static WallPaperCubit get(context) => BlocProvider.of(context);

  var isWallpaperDownloaded;
  var currentIndex = 0;

  CuratedModel? curatedModel;
  List<PhotosModel> wallPaperList = [];
  List<PhotosModel> searchWallpaperList = [];
  List<PhotosModel> favouriteWallpaperList = [];
  TextEditingController searchController = TextEditingController();

  int page = Random().nextInt(200) + 1;

  Future<void> getCurated() async {
    emit(CuratedLoadingState());

    await DioHelper.getData(
      url: curated + page.toString(),
      token: token,
    ).then(
      (value) {
        curatedModel = CuratedModel.fromJson(value.data);
        print('curatedModel!.photos!.length ${curatedModel!.photos!.length}');
        wallPaperList = curatedModel!.photos!;
        print('model Loaded Successfully');
        print(value.data);
        print('------------------------------------');
        print('nextPage :${curatedModel!.nextPage}');

        emit(CuratedSuccessState(curatedModel!));
      },
    ).catchError((error) {
      emit(CuratedErrorState(error));
    });
  }

  bool isLoaded = false;
  bool isSearchClicked = false;

  Future<bool> loadMoreWallPapers() async {
    emit(WallPaperLoadMoreLoadingState());
    page++;
    print('curatedModel nextPage: ${curated + page.toString()}');

    await DioHelper.getData(
      url: curated + page.toString(),
      // curatedModel!.nextPage!,
    ).then((value) {
      emit(WallPaperLoadMoreSuccessState());

      print('wallPaperList before${wallPaperList.length}');

      wallPaperList.addAll(CuratedModel.fromJson(value.data).photos!);

      print('More WallPaper Successfully');
      print('wallPaperList before${wallPaperList.length}');

      isLoaded = true;
    }).catchError((error) {
      emit(WallPaperLoadMoreErrorState(error));
      isLoaded = false;
    });
    print('load more: $isLoaded');
    return isLoaded;
  }

  void SearchWallPaper(String text) async {
    emit(WallPaperSearchLoadingState());

    await DioHelper.searchPhotos(
      url: searchUrl,
      query: {
        'query': text.toString(),
      },
    ).then((value) {
      print(value.data);
      searchWallpaperList = CuratedModel.fromJson(value.data).photos!;
      emit(WallPaperSearchSuccessState());
    }).catchError((error) {
      emit(WallPaperSearchErrorState(error));
    });
  }

  bool isDownloaded = false;
  bool isScreenWallPaperSet = false;
  bool isLockWallPaperSet = false;
  bool isBothWallPaperSet = false;

  void isScreenWallPaperSetLoading() {
    isScreenWallPaperSet = !isScreenWallPaperSet;
    emit(isScreenWallPaperSetState());
  }

  void isLockWallPaperSetLoading() {
    isLockWallPaperSet = !isLockWallPaperSet;
    emit(isLockWallPaperSetState());
  }

  void isBothWallPaperSetLoading() {
    isBothWallPaperSet = !isBothWallPaperSet;
    emit(isBothWallPaperSetState());
  }

  void isDownloadToMediaFileLoading() {
    isDownloaded = !isDownloaded;
    emit(WallPaperDownloadState());
  }

  void downloadInMediaFile(BuildContext context, PhotosModel photo) async {
    emit(WallPaperDownloadInMediaFileLoadingState());
    isDownloadToMediaFileLoading();

    await GallerySaver.saveImage(
      photo.src!.portrait!,
      toDcim: true,
      albumName: 'Just Wallpaper',
    ).then((value) {
      emit(WallPaperDownloadInMediaFileSuccessState());
      isDownloadToMediaFileLoading();
      print('Image Saved');

      Fluttertoast.showToast(
          msg: 'Image Saved',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      emit(WallPaperDownloadInMediaFileErrorState(error.toString()));
    });
  }

  void setHomeWallPaper(PhotosModel photo) async {
    emit(WallPaperSetHomeWallpaperLoadingState());
    isScreenWallPaperSetLoading();
    print('photo.src!.original!');
    print(photo.src!.original!);

    var cachedImage = await DefaultCacheManager()
        .getSingleFile(photo.src!.portrait!); //image file

    int location = WallpaperManagerFlutter.HOME_SCREEN;
    WallpaperManagerFlutter()
        .setwallpaperfromFile(cachedImage, location)
        .then((value) {
      isScreenWallPaperSetLoading();
      Fluttertoast.showToast(msg: 'Screen Wallpaper Set Successfully');
      cachedImage.deleteSync();
      emit(WallPaperSetHomeWallpaperSuccessState());
    }).catchError((error) {
      emit(WallPaperSetHomeWallpaperErrorState(error));
      print('error: $error');
    });
  }

  void setLockWallPaper(PhotosModel photo) async {
    emit(WallPaperSetLockWallpaperLoadingState());
    isLockWallPaperSetLoading();
    var cachedImage = await DefaultCacheManager()
        .getSingleFile(photo.src!.portrait!); //image file

    int location = WallpaperManagerFlutter.LOCK_SCREEN;
    WallpaperManagerFlutter()
        .setwallpaperfromFile(cachedImage, location)
        .then((value) {
      isLockWallPaperSetLoading();
      cachedImage.deleteSync();
      Fluttertoast.showToast(msg: 'Lock Wallpaper Set Successfully');
      emit(WallPaperSetLockWallpaperSuccessState());
    }).catchError((error) {
      emit(WallPaperSetLockWallpaperErrorState(error));
      print('error: $error');
    });
  }

  void setBothWallPaper(PhotosModel photo) async {
    emit(WallPaperSetBothWallpaperLoadingState());
    isBothWallPaperSetLoading();
    var cachedImage = await DefaultCacheManager()
        .getSingleFile(photo.src!.portrait!); //image file

    int location = WallpaperManagerFlutter.BOTH_SCREENS;
    WallpaperManagerFlutter()
        .setwallpaperfromFile(cachedImage, location)
        .then((value) {
      isBothWallPaperSetLoading();
      cachedImage.deleteSync();
      emit(WallPaperSetBothWallpaperSuccessState());
    }).catchError((error) {
      emit(WallPaperSetBothWallpaperErrorState(error));
      print('error: $error');
    });
  }

  void shareWallPaperFile(PhotosModel photo) async {
    emit(ShareWallPaperFileLoadingState());

    var cachedImage = await DefaultCacheManager()
        .getSingleFile(photo.src!.portrait!); //image file

    await FlutterShare.shareFile(
      title: 'Share WallPaper',
      text: '${photo.id}',
      filePath: cachedImage.path,
      chooserTitle: 'Share WallPaper to',
    ).then((value) {
      emit(ShareWallPaperFileSuccessState());
      value! ? print('Share Success') : print('Share Failed');
    }).catchError((error) {
      emit(ShareWallPaperFileErrorState(error));
      print(error.toString());
    });
  }

  List<Widget> tabs = [
    Tab(
      text: 'Main',
    ),
    Tab(
      text: 'Favorites',
    ),
    // Tab(
    //   text: 'Collections',
    // ),
  ];

  List<Widget> tabWidgets = [
    MainWidget(),
    FavouriteWidget(),
    SearchWidget(),
    // CollectionWidget(),
  ];

  void changeTab(int index) {
    isSearchClicked == true ? currentIndex = 2 : currentIndex = index;
    emit(ChangeTabState(index));
  }

  void changeSearchbarClicked() {
    isSearchClicked = !isSearchClicked;
    debugPrint('isSearchClicked ${isSearchClicked}');
    emit(WallPaperSearchSuccessState());
  }

  Widget tabViewChange(int index) {
    switch (index) {
      case 0:
        return MainWidget();
      case 1:
        return FavouriteWidget();
      case 2:
        return SearchWidget();
      default:
        return Container();
    }
  }
}
