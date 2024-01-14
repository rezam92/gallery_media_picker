import 'package:flutter/material.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GalleryMediaPicker(
              childAspectRatio: 1,
              crossAxisCount: 3,
              thumbnailQuality: 200,
              thumbnailBoxFix: BoxFit.cover,
              singlePick: false,
              // imageBackgroundColor: Colors.red,
              onlyImages: true,
              onlyVideos: true,
              maxPickImages: 5,
              appBarHeight: 60,
              appBarColor: Colors.white,
              appBarIconColor: Colors.black,
              appBarTextColor: Colors.black,
              gridViewBackgroundColor: Colors.white,
              selectedBackgroundColor: Colors.black,
              selectedCheckColor: Colors.black87,
              selectedCheckBackgroundColor: Colors.white10,
              onMaxFileEvent: () {
                // var locator = getIt.get<INotification>();
                // locator.showGeneral(context: context, title: ('error').tr, msg: ('maxTenSlide').tr);
              },
              pathList: (paths) {
                // try {
                //   if (paths.isEmpty) {
                //     context.read<CreatePostCubit>().changeList([]);
                //   } else if (paths.length > selectedMedia.length) {
                //     List<PickedAssetModel> newer = List.from(paths)
                //       ..removeWhere((e) => selectedMedia.where((t) => t.entity.id == e.id).isNotEmpty);
                //     List<CreatePostMedia> list = newer.map((e) {
                //       return CreatePostMedia(
                //         entity: AssetEntity(
                //           id: e.id!,
                //           // ?? const Uuid().v1(),
                //           height: e.height ?? 0,
                //           width: e.width ?? 0,
                //           typeInt: e.type == 'video' ? AssetType.video.index : AssetType.image.index,
                //           orientation: e.orientation ?? 0,
                //         ),
                //         file: e.file,
                //         thumb: e.thumbnail,
                //         // fileByte: e.file?.readAsBytesSync(),
                //         // originFileByte: e.file?.readAsBytesSync(),
                //       );
                //     }).toList();
                //     context.read<CreatePostCubit>().changeList(List.from(selectedMedia)..addAll(list));
                //   } else if (paths.length < selectedMedia.length) {
                //     List<CreatePostMedia> older = List.from(selectedMedia)
                //       ..removeWhere((e) => paths.where((t) => t.id == e.entity.id).isEmpty);
                //     context.read<CreatePostCubit>().changeList(older);
                //   } else {
                //     List<CreatePostMedia> list = [];
                //     for (var o in paths) {
                //       list.add(selectedMedia.where((e) => e.entity.id == o.id).first);
                //       context.read<CreatePostCubit>().changeList(list);
                //     }
                //   }
                // } catch (e) {
                //   Sentry.captureException(e);
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
