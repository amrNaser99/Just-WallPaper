import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justwallpaper/home/presentation/cubit/wallpaper_cubit.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';

class SearchBarLayout extends StatelessWidget {
  const SearchBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colorDarkGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        style: TextStyle(
          color: whiteColor.withOpacity(0.7),
        ),
        controller: WallPaperCubit.get(context).searchController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          prefixIcon: Icon(
            IconBroken.Search,
            color: whiteColor,
            size: 25,
          ),
          hintStyle: TextStyle(
            color: whiteColor.withOpacity(0.7),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field must be not Empty';
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          WallPaperCubit.get(context).SearchWallPaper(value);
        },
      ),
    );
    // return Container(
    //   height: 50,
    //   padding: EdgeInsets.all(20.0),
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Row(
    //     children: [
    //       const SizedBox(
    //         width: 10,
    //       ),
    //       const Icon(
    //         Icons.search,
    //         color: Colors.grey,
    //       ),
    //       const SizedBox(
    //         width: 10,
    //       ),
    //       const Text(
    //         'Search',
    //         style: TextStyle(
    //           color: Colors.grey,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}


