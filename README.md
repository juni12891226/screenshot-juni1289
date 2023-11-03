A Flutter widget that can take screen shots

## Features

#### A flutter widget that:

* Will ask for the Permission so you don't have to ask by yourself - You just have to add permissions for Android & iOS (Storage Permissions only)
* Will take the Global key as required param - You just have to enclose your desired widget inside the RePaint boundary and provide a unique Global key
* Will take the filename as required param - You can create the file name inside this package too ;)
* Will take the save directory - For Android you can set your desired directory, the default is Downloads

## Additional information

* Easy to use and manage
* You just have to provide your params
* Responds with a callback so you can know about your screen shot taken!

## Basic Setup

```
    RepaintBoundary(key: screenShotKey, child: const FlutterLogo(size: 60,))
    
    ScreenShotHelperUtil.instance.takeAndSaveScreenShot(
        context: context,
        repaintBoundaryKey: screenShotKey,
        filename: ScreenShotHelperUtil.instance.getFileNameForSave(fileNamePrefix: "screenshot_"),
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
```

## Signature Example

```
    Future<void> takeAndSaveScreenShot(
      {required BuildContext context,
      required GlobalKey repaintBoundaryKey,
      required String filename,
      required String imageToSaveCustomDirectoryName,
      required Function(ScreenShotHelperModel? screenShotHelperModel) onScreenShotSavedCallback,
      String? androidSystemDirectoryPath,
      double? pixelRatio}) async
```
