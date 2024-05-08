import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot_juni1289/screenshot/enums/enums.dart';
import 'package:screenshot_juni1289/screenshot/exception/screen_shot_helper_exception.dart';
import 'package:screenshot_juni1289/screenshot/model/permission_handler_helper_model.dart';
import 'package:screenshot_juni1289/screenshot/model/screen_shot_result_helper_model.dart';
import 'package:screenshot_juni1289/screenshot/permission/permission_helper_util.dart';

class ScreenShotHelperUtil {
  /// private constructor
  ScreenShotHelperUtil._();

  /// the one and only instance of this singleton
  static final instance = ScreenShotHelperUtil._();

  ///takes the screen shot and then save
  ///[context] is required
  ///[repaintBoundaryKey] is the Global key that you will have to assign to the repaint boundary widget
  ///[filename] is the name of the file that want to save the screen shot with
  ///[imageToSaveCustomDirectoryName] the custom directory inside the system directory | for creating a separate directory to save this image in
  ///[androidSystemDirectoryPath] the system directory | for now only for Android, default is downloads directory for Android and for iOS is documents directory
  ///[onScreenShotSavedCallback] is the call back with the model populated with the data about the method success, permission result and save success!
  ///[pixelRatio] for screen ratio, default is 1
  Future<void> takeAndSaveScreenShot(
      {required BuildContext context,
      required GlobalKey repaintBoundaryKey,
      required String filename,
      required String imageToSaveCustomDirectoryName,
      required Function(ScreenShotHelperModel? screenShotHelperModel) onScreenShotSavedCallback,
      String? androidSystemDirectoryPath,
      double? pixelRatio}) async {
    if (repaintBoundaryKey.currentContext != null && repaintBoundaryKey.currentContext!.findRenderObject() != null) {
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: pixelRatio ?? 1);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes;
      if (byteData != null) {
        pngBytes = byteData.buffer.asUint8List();
        PermissionHelperUtil.instance.checkIfStoragePermissionGranted().then((PermissionHandlerHelperModel? permissionHandlerHelperModel) async {
          if (permissionHandlerHelperModel != null) {
            if (permissionHandlerHelperModel.permissionsResult == PermissionsResultsEnums.granted) {
              String newPath = await createDirectory(context: context, androidDirectoryPath: androidSystemDirectoryPath);
              var directory = Directory('$newPath/$imageToSaveCustomDirectoryName');
              directory.exists().then((bool isExists) {
                if (isExists) {
                  final imagePath = "${directory.path}/$filename";
                  File(imagePath).writeAsBytes(pngBytes).then((value) {
                    onScreenShotSavedCallback(
                        ScreenShotHelperModel(saveSuccess: true, savedImagePath: imagePath, permissionsResultsEnum: PermissionsResultsEnums.granted, errorReason: null));
                  }, onError: (e) {
                    onScreenShotSavedCallback(ScreenShotHelperModel(
                        saveSuccess: false, savedImagePath: null, permissionsResultsEnum: PermissionsResultsEnums.granted, errorReason: "Error Code 0120:::$e"));
                  });
                } else {
                  directory.create(recursive: true).then((Directory createdDirectory) {
                    final imagePath = "${createdDirectory.path}/$filename";
                    File(imagePath).writeAsBytes(pngBytes).then((value) {
                      onScreenShotSavedCallback(
                          ScreenShotHelperModel(savedImagePath: imagePath, permissionsResultsEnum: PermissionsResultsEnums.granted, errorReason: null, saveSuccess: true));
                    }, onError: (e) {
                      onScreenShotSavedCallback(ScreenShotHelperModel(
                          saveSuccess: false, savedImagePath: null, permissionsResultsEnum: PermissionsResultsEnums.granted, errorReason: "Error Code 0122:::$e"));
                    });
                  });
                }
              });
            } else if (permissionHandlerHelperModel.permissionsResult == PermissionsResultsEnums.denied) {
              onScreenShotSavedCallback(ScreenShotHelperModel(
                  saveSuccess: false, savedImagePath: null, permissionsResultsEnum: PermissionsResultsEnums.denied, errorReason: "Permission is denied!"));
            } else if (permissionHandlerHelperModel.permissionsResult == PermissionsResultsEnums.permanentlyDenied) {
              onScreenShotSavedCallback(ScreenShotHelperModel(
                  saveSuccess: false,
                  savedImagePath: null,
                  permissionsResultsEnum: PermissionsResultsEnums.permanentlyDenied,
                  errorReason: "Permission is permanently denied!"));
            }
          } else {
            onScreenShotSavedCallback(
                ScreenShotHelperModel(saveSuccess: false, savedImagePath: null, permissionsResultsEnum: null, errorReason: "Permission helper model is null!"));
          }
        });
      } else {
        onScreenShotSavedCallback(
            ScreenShotHelperModel(saveSuccess: false, savedImagePath: null, permissionsResultsEnum: null, errorReason: "Image is null, Error Code 0123"));
      }
    } else {
      onScreenShotSavedCallback(ScreenShotHelperModel(
          saveSuccess: false, savedImagePath: null, permissionsResultsEnum: null, errorReason: "Repaint Boundary/Current Context/Render Object is null, Error Code 0124"));
    }
  }

  /// Get file name for saving the image
  /// [fileNamePrefix] is required, to be appended in the start of the file name
  /// For example the [fileNamePrefix] is myfile_ then the file name returned would be myfile_(getFileNameForSaveResult)
  /// [fileExtension] is the extension of the file that needs to saved, default is .png
  String getFileNameForSave({required String fileNamePrefix, String fileExtension = ".png"}) {
    if (fileExtension.startsWith(".")) {
      return (fileNamePrefix.isNotEmpty ? fileNamePrefix : _getRandomNumber()) + (DateTime.now()).toString() + fileExtension;
    }
    throw ScreenShotHelperException(cause: "The file extension is not correct!");
  }

  ///get the random number
  ///for the file saving purposes
  ///to make the file name unique
  String _getRandomNumber() {
    int range = 9999;
    Random random = Random();

    return ((((random.nextInt(range) / random.nextInt(range)) * random.nextInt(range)) / random.nextInt(range) * random.nextInt(range)).toString()).replaceAll(".", "");
  }

  ///To create the directory for saving the file
  ///[context] is required
  ///[androidDirectoryPath] is optional and default is Download directory path | if you want another android directory
  ///For iOS the directory is Application Documents Directory
  Future<String> createDirectory({required BuildContext context, String? androidDirectoryPath}) async {
    String pathToDirectory = "";
    if (Platform.isAndroid) {
      //for android
      pathToDirectory = Directory(androidDirectoryPath ?? '/storage/emulated/0/Download').path;
    } else if (Platform.isIOS) {
      //for iOS
      Directory directory = await getApplicationDocumentsDirectory();
      pathToDirectory = directory.path;
    } else {
      throw ScreenShotHelperException(cause: "Platform exception! (only Android & iOS Platforms compatible)");
    }

    bool isExists = await Directory(pathToDirectory).exists();

    if (!isExists) {
      Directory(pathToDirectory).create();
    }

    return pathToDirectory;
  }
}
