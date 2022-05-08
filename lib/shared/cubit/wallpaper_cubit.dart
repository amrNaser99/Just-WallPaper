import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:justwallpaper/model/curated_model.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_states.dart';
import 'package:justwallpaper/shared/network/remote/dio_helper.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import '../components/constants.dart';

class WallPaperCubit extends Cubit<WallPaperStates> {
  var isWallpaperDownloaded;


  WallPaperCubit() : super(WallPaperInitialState());

  static WallPaperCubit get(context) => BlocProvider.of(context);

  CuratedModel? curatedModel;
  List<Photos> wallPaperList = [];
  List<Photos> moreWallPaperList = [];

  int page = Random().nextInt(100) + 1;

  Future<void> getCurated() async {
    emit(CuratedLoadingState());

    await DioHelper.getData(
      url:
          // baseURL+CURATED,
          curated + page.toString(),
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

        emit(CuratedSuccessState());
      },
    ).catchError((error) {
      emit(CuratedErrorState(error));
    });
  }

  bool isLoaded = false;

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


  void downloadInMediaFile(BuildContext context, Photos photo) async {
    emit(WallPaperDownloadInMediaFileLoadingState());
    isDownloadToMediaFileLoading();

    await GallerySaver.saveImage(
      photo.src!.portrait!,
      toDcim: true,
      albumName: 'Just Wallpaper',
    )
        .then((value) {
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

  void setHomeWallPaper(Photos photo) async {
    emit(WallPaperSetHomeWallpaperLoadingState());
    isScreenWallPaperSetLoading();
    print('photo.src!.original!');
    print(photo.src!.original!);

    var cachedImage = await DefaultCacheManager()
    //TODO port or original url
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

  void setLockWallPaper(Photos photo) async {
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

  void setBothWallPaper(Photos photo) async {
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

  void shareWallPaperFile(Photos photo) async {
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
}
