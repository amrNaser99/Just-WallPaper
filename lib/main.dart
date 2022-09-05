import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/module/splash/splash_screen.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_states.dart';
import 'package:justwallpaper/shared/network/remote/dio_helper.dart';
import 'package:justwallpaper/shared/styles/themes.dart';
import 'module/home_screen.dart';

import 'shared/bloc_observer.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  BlocOverrides.runZoned(
    () {
      runApp(const SplashScreen());
    },
    blocObserver: MyBlocObserver(),
  );
}
