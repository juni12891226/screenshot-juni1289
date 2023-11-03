///custom exception class for handling the custom exceptions
///only for screen shot helper util
class ScreenShotHelperException implements Exception {
  String cause;

  ScreenShotHelperException({required this.cause});
}
