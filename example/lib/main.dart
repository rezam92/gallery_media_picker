import 'dart:io';

import 'package:better_video_player/better_video_player.dart';
import 'package:example/src/provider/imageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

void main() {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => PickerDataProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool _singlePick = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<PickerDataProvider>(
        builder: (context, media, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  height: 300,
                  color: Colors.white,
                  child: media.pickedFile.isEmpty

                      /// no images selected
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 8,
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                'No images selected',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                              )
                            ],
                          ),
                        )

                      /// selected images
                      : Column(
                          children: [
                            if (media.pickedFile.last.type == 'image')
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.56,
                                child: Image.file(File(media.pickedFile.last.path)),
                              )
                            else
                              AspectRatio(
                                aspectRatio: 16.0 / 9.0,
                                child: BetterVideoPlayer(
                                  configuration: const BetterVideoPlayerConfiguration(
                                    looping: true,
                                    autoPlay: true,
                                    allowedScreenSleep: false,
                                    autoPlayWhenResume: true,
                                  ),
                                  controller: BetterVideoPlayerController(),
                                  dataSource: BetterVideoPlayerDataSource(
                                    BetterVideoPlayerDataSourceType.file,
                                    media.pickedFile.last.path,
                                  ),
                                ),
                              )
                          ],
                        ),
                ),

                /// gallery media picker
                Expanded(
                  child: GalleryMediaPicker(
                    childAspectRatio: 1,
                    crossAxisCount: 3,
                    thumbnailQuality: 200,
                    thumbnailBoxFix: BoxFit.cover,
                    singlePick: _singlePick,
                    // imageBackgroundColor: Colors.red,
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
                      print("========uiohu");
                    },
                    pathList: (paths) {
                      print(paths.map((e) => e.id));
                      setState(() {
                        /// for this example i used provider, you can choose the state management that you prefer
                        media.pickedFile = paths;
                      });
                    },

                    /// select multiple image
                    appBarLeadingWidget: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, bottom: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// select multiple / single
                            SizedBox(
                              height: 30,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _singlePick = !_singlePick;
                                        });
                                        debugPrint(_singlePick.toString());
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: Colors.blue, width: 1.5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Select multiple',
                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 10),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Transform.scale(
                                                scale: 1.5,
                                                child: Icon(
                                                  _singlePick ? Icons.check_box_outline_blank : Icons.check_box_outlined,
                                                  color: Colors.blue,
                                                  size: 10,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
