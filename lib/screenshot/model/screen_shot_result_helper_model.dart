import 'package:screenshot_juni1289/screenshot/enums/enums.dart';

class ScreenShotHelperModel {
  String? savedImagePath;
  PermissionsResultsEnums? permissionsResultsEnum;
  String? errorReason;
  bool saveSuccess;

  ///helper model class for screen shot response callback
  ///holds the information about the screen shot being captured, permissions, path etc
  ///[savedImagePath] for image path where the screen shot image is saved
  ///[errorReason] reason string for any error that occurred
  ///[permissionsResultsEnum] permission results
  ///[saveSuccess] true | false about the screen shot save success | failure
  ScreenShotHelperModel(
      {this.savedImagePath,
      this.errorReason,
      this.permissionsResultsEnum,
      required this.saveSuccess});
}
