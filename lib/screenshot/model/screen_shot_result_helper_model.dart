import 'package:screenshot_juni1289/screenshot/enums/enums.dart';

class ScreenShotHelperModel {
  String? savedImagePath;
  PermissionsResultsEnums? permissionsResultsEnum;
  String? errorReason;
  bool saveSuccess;

  ScreenShotHelperModel({this.savedImagePath, this.errorReason, this.permissionsResultsEnum, required this.saveSuccess});
}
