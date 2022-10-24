import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/presentation/pages/splash/splash_screen.dart';
import 'core/services/remote/dio_helper.dart';
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
