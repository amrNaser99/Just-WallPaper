import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';
import 'package:justwallpaper/shared/styles/colors.dart';
import 'package:justwallpaper/shared/styles/themes.dart';

import '../../cubit/wallpaper_states.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WallPaperCubit>(
      create: (context) => WallPaperCubit()..getCurated(),
      child: BlocConsumer<WallPaperCubit, WallPaperStates>(
        listener:  (context, state) {
        //   if (state is CuratedSuccessState) {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const HomeScreen(),
        //       ),
        //     );
        //   }
        },
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            title: 'Just WallPaper',
            themeMode: ThemeMode.light,
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
                navigator: HomeScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}