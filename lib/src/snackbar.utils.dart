import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  ///消息提示
  static showInfo(String title, String message) {
    _baseShow(
      title,
      message,
      Colors.black,
    );
  }

  ///成功提示
  static showSuccess(String title) {
    _baseShow(title, '成功提醒', const Color(0xFF19be6b));
  }

  ///错误提示
  static showError(String title) {
    _baseShow(title, '', const Color(0xFFFF9900));
  }

  static _baseShow(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
        ),
        messageText: Text(
          message,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white),
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(0),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: backgroundColor);
  }
}
