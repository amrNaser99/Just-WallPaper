import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/shared/cubit/wallpaper_states.dart';
import 'package:justwallpaper/shared/styles/colors.dart';
import '../../main.dart';
import '../../shared/components/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallPaperCubit()..getCurated(),
      child: BlocConsumer<WallPaperCubit, WallPaperStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          WallPaperCubit cubit = BlocProvider.of<WallPaperCubit>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              extendBodyBehindAppBar: true,
              body: EasySplashScreen(
                backgroundColor: colorDark,
                logo: Image.asset(
                  'assets/images/logo_transparent.png',
                ),
                durationInSeconds: 2,
                logoSize: 200,
                loadingText: const Text(
                  'Developed By Amr Nasser',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                showLoader: true,
                loaderColor: Colors.white,
                navigator: MyApp(),
              ),
            ),
          );
        },
      ),
    );
  }
}
