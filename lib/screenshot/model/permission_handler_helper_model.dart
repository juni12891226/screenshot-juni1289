import 'package:screenshot_juni1289/screenshot/enums/enums.dart';

class PermissionHandlerHelperModel {
  PermissionsResultsEnums permissionsResult;
  String permissionName;

  ///[permissionsResult] is required
  ///[permissionName] is required, helps in logs
  PermissionHandlerHelperModel(
      {required this.permissionsResult, required this.permissionName});
}
