import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:justwallpaper/home/data/models/photos_model.dart';
import 'package:justwallpaper/shared/styles/colors.dart';
import 'package:justwallpaper/shared/styles/icon_broken.dart';

import '../../home/presentation/cubit/wallpaper_cubit.dart';
import '../../home/presentation/widgets/search_layout.dart';

// Container(
// padding: EdgeInsetsDirectional.only(start: 10, end: 10),
// height: 24,
// child: ListView.separated(
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) => InkWell(
// onTap: () {
// WallPaperCubit.get(context).changeTab(index);
// },
// child: Container(
// width: SizeConfig.screenWidth! / 3,
// height: 20,
// decoration: BoxDecoration(
// color: WallPaperCubit.get(context).currentIndex == index
// ? colorPrimary
//     : Colors.grey[800]!.withOpacity(0.2),
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Text(
// WallPaperCubit.get(context).tabs[index],
// style: TextStyle(
// color: Colors.white,
// fontSize: 16,
// ),
// ),
// ),
// ),
// ),
// separatorBuilder: (context, index) => SizedBox(
// width: 8,
// ),
// itemCount: WallPaperCubit.get(context).tabs.length,
// ),
// )

// defaultAppBar(BuildContext context, List<Widget> tabs,
//         WallPaperCubit cubit) =>
//     SliverAppBar(
//       centerTitle: true,
//       floating: true,
//       pinned: true,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Just',
//             style: TextStyle(
//               color: colorPrimary,
//               fontSize: 19,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             'WallPaper',
//             style: TextStyle(
//                 color: colorLight, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//       actions: [
//         cubit.isSearchClicked
//             ? IconButton(
//                 padding: EdgeInsetsDirectional.only(
//                   end: 20,
//                 ),
//                 onPressed: () {
//                   cubit.changeSearchbarClicked();
//                 },
//                 icon: Icon(
//                   IconBroken.Arrow___Up_2,
//                   color: whiteColor,
//                   size: 25,
//                 ),
//               )
//             : IconButton(
//                 padding: EdgeInsetsDirectional.only(
//                   end: 20,
//                 ),
//                 onPressed: () {
//                   cubit.changeSearchbarClicked();
//                 },
//                 icon: Icon(
//                   IconBroken.Search,
//                   color: whiteColor,
//                   size: 25,
//                 ),
//               ),
//       ],
//       bottom: cubit.isSearchClicked
//           ? PreferredSize(
//               child: SearchBarLayout(),
//               preferredSize: Size.fromHeight(
//                 50,
//               ),
//             )
//           : TabBar(
//          tabs: tabs,
//
//               labelPadding: EdgeInsetsDirectional.only(
//                 start: 10,
//                 end: 10,
//               ),
//               physics: const BouncingScrollPhysics(),
//               indicatorColor: colorPrimary,
//             ),
//     );

// Widget searchBar(BuildContext context) {
//   TextEditingController searchController = TextEditingController();
//   return Container(
//     height: 40,
//     decoration: BoxDecoration(
//       color: colorDarkGrey,
//       borderRadius: BorderRadius.circular(30),
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     margin: const EdgeInsets.symmetric(horizontal: 40),
//     child: TextFormField(
//       style: TextStyle(
//         color: whiteColor.withOpacity(0.7),
//       ),
//       controller: searchController,
//       keyboardType: TextInputType.text,
//       decoration: InputDecoration(
//         hintText: 'Search',
//         border: InputBorder.none,
//         prefixIcon: Icon(
//           IconBroken.Search,
//           color: whiteColor,
//           size: 25,
//         ),
//         hintStyle: TextStyle(
//           color: whiteColor.withOpacity(0.7),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Field must be not Empty';
//         } else {
//           return null;
//         }
//       },
//       onFieldSubmitted: (value) {
//         BlocProvider.of<WallPaperCubit>(context).SearchWallPaper(value);
//       },
//     ),
//   );
// }

dynamic showSnackBar(String message) {
  SnackBar(content: Text(message), duration: Duration(seconds: 2));
}

Future<void> shareLink(PhotosModel photo) async {
  await FlutterShare.share(
    title: 'Share',
    text: 'share WallPaper',
    linkUrl: photo.url,
    chooserTitle: photo.photographer,
  );
}

Future<void> shareFile(PhotosModel photo) async {
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
