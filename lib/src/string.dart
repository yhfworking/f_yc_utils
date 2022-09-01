import 'dart:convert';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safe_device/safe_device.dart';
import 'package:uuid_helper/uuid_helper.dart';

class StringUtils {
  ///获取全局唯一UUID
  static Future<String> uuid() async {
    var uuid = await UUIDHelper.getUniqueId();
    if (uuid.isNotEmpty) {
      return uuid;
    }
    return '';
  }

  ///比较版本
  static Future<bool> isLessCompareVersion(String targetVersion) async {
    if (targetVersion.isNotEmpty) {
      targetVersion = targetVersion.replaceAll('.', '');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var currentVersion = packageInfo.version;
      currentVersion = currentVersion.replaceAll('.', '');
      if (int.parse(targetVersion) > int.parse(currentVersion)) {
        return true;
      }
    }
    return false;
  }

  static String platform() {
    return "app-plus";
  }

  static String os() {
    return GetPlatform.isIOS ? 'ios' : (GetPlatform.isAndroid ? 'android' : '');
  }

  static Future<int> batteryLevel() async {
    bool isRealDevice = await SafeDevice.isRealDevice;
    if (!isRealDevice) {
      return 999;
    }
    return await Battery().batteryLevel;
  }

  static Future<String> connectionStatus() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      return 'wifi';
    } else if (connectivityResult == ConnectivityResult.mobile) {
      return 'mobile';
    } else if (connectivityResult == ConnectivityResult.none) {
      return 'none';
    }
    return 'unkown';
  }

  static Future<String> ua() async {
    Map<String, dynamic> map = Map.from({});
    map['platform'] =
        GetPlatform.isIOS ? 'ios' : (GetPlatform.isAndroid ? 'android' : '');
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      map['deviceInfo'] = iosDeviceInfo.toMap();
    } else if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      map['deviceInfo'] = {
        "brand": androidDeviceInfo.brand ?? '',
        "device": androidDeviceInfo.device ?? '',
        "display": androidDeviceInfo.display ?? '',
        "model": androidDeviceInfo.model ?? '',
        "product": androidDeviceInfo.product ?? '',
        "isPhysicalDevice": androidDeviceInfo.isPhysicalDevice,
        "androidId": androidDeviceInfo.id ?? ''
      };
    }
    map['platform'] = platform();
    map['os'] = os();
    map['battery'] = await batteryLevel();
    map['connectionStatus'] = await connectionStatus();
    return json.encode(map);
  }
}
