///permission results enums
///to get the permission results in the response callback
enum PermissionsResultsEnums {
  granted, //permission is/already granted
  denied, //user denies the permission
  permanentlyDenied, //user permanently denied the permission, have to manually grant the permission
  isRestricted
}