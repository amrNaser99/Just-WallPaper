import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:justwallpaper/model/curated_model.dart';
import 'package:justwallpaper/shared/styles/colors.dart';
import 'package:justwallpaper/shared/styles/icon_broken.dart';

AppBar defaultAppBar() => AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Just',
            style: TextStyle(
              color: colorPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'WallPaper',
            style: TextStyle(
                color: colorLight,
                // Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        // IconButton(
        //   padding: EdgeInsetsDirectional.only(
        //     end: 20,
        //   ),
        //   onPressed: () {},
        //   icon: Icon(
        //     IconBroken.Setting,
        //     color: whiteColor,
        //   ),
        // ),
      ],
    );

Widget searchBar() {
  TextEditingController searchController = TextEditingController();
  return Container(
    decoration: BoxDecoration(
      color: colorDarkGrey,
      // Colors.black38,
      borderRadius: BorderRadius.circular(30),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.symmetric(horizontal: 40),
    child: TextFormField(
      style: TextStyle(
        color: whiteColor.withOpacity(0.7),
      ),
      controller: searchController,
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
      onChanged: (value) {
        // DioHelper.getData(url: )
      },
    ),
  );
}

dynamic showSnackBar(String message) {
  SnackBar(content: Text(message), duration: Duration(seconds: 2));
}

Future<void> shareLink(Photos photo) async {
  await FlutterShare.share(
    title: 'Share',
    text: 'share WallPaper',
    linkUrl: photo.url,
    chooserTitle: photo.photographer,
  );
}

Future<void> shareFile(Photos photo) async {
  await FlutterShare.shareFile(
    title: 'Example share',
    text: 'Example share text',
    filePath: photo.src!.original.toString(),
  );
}

buildConditionalBuilderLoading(BuildContext context, condition, builder) {
  ConditionalBuilder(
    condition: condition,
    builder: (context) => builder,
    fallback: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}
