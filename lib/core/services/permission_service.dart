import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestMicrophone() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  static Future<bool> requestStorage() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<bool> requestLocation() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }
}
