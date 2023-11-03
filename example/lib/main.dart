import 'package:flutter/material.dart';
import 'package:tec_app_utils/apputil/app_util_helper.dart';
import 'package:tec_app_utils/screenshot/helper/screen_shot_helper_util.dart';
import 'package:tec_app_utils/screenshot/model/screen_shot_result_helper_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var screenShotKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(key: screenShotKey, child: const FlutterLogo()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _takeScreenShot(context, screenShotKey);
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _takeScreenShot(BuildContext context, GlobalKey<State<StatefulWidget>> screenShotKey) {
    ScreenShotHelperUtil.instance.takeAndSaveScreenShot(
        context: context,
        repaintBoundaryKey: screenShotKey,
        filename: AppHelperUtil.instance.getFileNameForSave(prefix: "screenshot_"),
        imageToSaveCustomDirectoryName: "ScreenShot_juni1289",
        onScreenShotSavedCallback: (ScreenShotHelperModel? screenShotHelperModel) {
          if (screenShotHelperModel != null) {
            //all good here
            if (screenShotHelperModel.saveSuccess) {
              //screen shot taken
              if (screenShotHelperModel.savedImagePath != null && screenShotHelperModel.savedImagePath!.isNotEmpty) {
                //the screen shot is finally saved, bingo!
              }
            }
          }
        });
  }
}
