/*import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

  @override
  void initState() {
    super.initState();
    checkPermission();
  }




  checkPermission() async {
    appPermissions.PermissionStatus locPer =
        await appPermissions.Permission.location.status;
    if (locPer != appPermissions.PermissionStatus.granted) {
      await appPermissions.Permission.location.request();
    }
  }*/