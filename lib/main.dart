import 'package:flutter/material.dart';
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

  BlocOverrides.runZoned(
    () {
      runApp(const SplashScreen());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WallPaperCubit,WallPaperStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just WallPaper',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: const HomeScreen(),
      );
      },
    );
  }
}
