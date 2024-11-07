import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot_juni1289/screenshot/enums/enums.dart';
import 'package:screenshot_juni1289/screenshot/exception/screen_shot_helper_exception.dart';
import 'package:screenshot_juni1289/screenshot/model/permission_handler_helper_model.dart';

class PermissionHelperUtil {
  /// private constructor
  PermissionHelperUtil._();

  /// the one and only instance of this singleton
  static final instance = PermissionHelperUtil._();

  ///Storage Permission
  ///For androidVersion >= 33
  Future<PermissionHandlerHelperModel?>
      checkIfStoragePermissionGranted() async {
    PermissionHandlerHelperModel? permissionHandlerHelperModel;
    String permissionName = "Permission.storage";

    //get the android version
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    var build = await deviceInfoPlugin.androidInfo;
    int androidVersion = 9999;
    try {
      androidVersion = build.version.sdkInt;
    } catch (exp) {
      throw ScreenShotHelperException(cause: exp.toString());
    }

    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.photos].request();

    if (statuses.isNotEmpty &&
        statuses[Permission.storage] != null &&
        statuses[Permission.storage]!.isGranted) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResultsEnums.granted,
          permissionName: permissionName);
    } else if (statuses.isNotEmpty &&
        statuses[Permission.storage] != null &&
        statuses[Permission.storage]!.isDenied) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResultsEnums.denied,
          permissionName: permissionName);
    } else if (statuses.isNotEmpty &&
        statuses[Permission.storage] != null &&
        statuses[Permission.storage]!.isPermanentlyDenied) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResultsEnums.permanentlyDenied,
          permissionName: permissionName);
    } else if (statuses.isNotEmpty &&
        statuses[Permission.storage] != null &&
        statuses[Permission.storage]!.isRestricted) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResultsEnums.isRestricted,
          permissionName: permissionName);
    }

    if (Platform.isIOS || (androidVersion != 9999) && androidVersion >= 33) {
      if (statuses.isNotEmpty &&
          statuses[Permission.photos] != null &&
          statuses[Permission.photos]!.isGranted) {
        permissionHandlerHelperModel = PermissionHandlerHelperModel(
            permissionsResult: PermissionsResultsEnums.granted,
            permissionName: permissionName);
      } else if (statuses.isNotEmpty &&
          statuses[Permission.photos] != null &&
          statuses[Permission.photos]!.isDenied) {
        permissionHandlerHelperModel = PermissionHandlerHelperModel(
            permissionsResult: PermissionsResultsEnums.denied,
            permissionName: permissionName);
      } else if (statuses.isNotEmpty &&
          statuses[Permission.photos] != null &&
          statuses[Permission.photos]!.isPermanentlyDenied) {
        permissionHandlerHelperModel = PermissionHandlerHelperModel(
            permissionsResult: PermissionsResultsEnums.permanentlyDenied,
            permissionName: permissionName);
      } else if (statuses.isNotEmpty &&
          statuses[Permission.photos] != null &&
          statuses[Permission.photos]!.isRestricted) {
        permissionHandlerHelperModel = PermissionHandlerHelperModel(
            permissionsResult: PermissionsResultsEnums.isRestricted,
            permissionName: permissionName);
      }
    }

    return permissionHandlerHelperModel;
  }
}
