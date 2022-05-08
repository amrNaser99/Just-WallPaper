import 'package:justwallpaper/model/curated_model.dart';

abstract class WallPaperStates {}

class WallPaperInitialState extends WallPaperStates {}

class CuratedLoadingState extends WallPaperStates {}
class WallPaperDownloadState extends WallPaperStates {}
class isScreenWallPaperSetState extends WallPaperStates {}
class isLockWallPaperSetState extends WallPaperStates {}
class isBothWallPaperSetState extends WallPaperStates {}

class WallPaperDownloadInMediaFileLoadingState extends WallPaperStates {}
class WallPaperDownloadInMediaFileSuccessState extends WallPaperStates {}
class WallPaperDownloadInMediaFileErrorState extends WallPaperStates {
  final String error;

  WallPaperDownloadInMediaFileErrorState(this.error);
}

class WallPaperSetHomeWallpaperLoadingState extends WallPaperStates {}
class WallPaperSetHomeWallpaperSuccessState extends WallPaperStates {}
class WallPaperSetHomeWallpaperErrorState extends WallPaperStates {
  final String error;
  WallPaperSetHomeWallpaperErrorState(this.error);
}
class WallPaperSetLockWallpaperLoadingState extends WallPaperStates {}
class WallPaperSetLockWallpaperSuccessState extends WallPaperStates {}
class WallPaperSetLockWallpaperErrorState extends WallPaperStates {
  final String error;
  WallPaperSetLockWallpaperErrorState(this.error);
}
class WallPaperSetBothWallpaperLoadingState extends WallPaperStates {}
class WallPaperSetBothWallpaperSuccessState extends WallPaperStates {}
class WallPaperSetBothWallpaperErrorState extends WallPaperStates {
  final String error;
  WallPaperSetBothWallpaperErrorState(this.error);
}

class CuratedSuccessState extends WallPaperStates {}
class CuratedErrorState extends WallPaperStates {
  final String error;

  CuratedErrorState(this.error);
}

class WallPaperLoadMoreLoadingState extends WallPaperStates {}
class WallPaperLoadMoreSuccessState extends WallPaperStates {}
class WallPaperLoadMoreErrorState extends WallPaperStates {
  final String error;

  WallPaperLoadMoreErrorState(this.error);
}

class ShareWallPaperFileLoadingState extends WallPaperStates {}
class ShareWallPaperFileSuccessState extends WallPaperStates {}
class ShareWallPaperFileErrorState extends WallPaperStates {
  final String error;
  ShareWallPaperFileErrorState(this.error);
}