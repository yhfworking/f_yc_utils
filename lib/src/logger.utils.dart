import 'dart:developer';
import 'package:flutter/foundation.dart';

class LoggerUtils {
  // Sample of abstract logging function
  static void write(String text, {bool isError = false}) {
    Future.microtask(() {
      if (kDebugMode) {
        log('** $text. isError: [$isError]');
      }
    });
  }
}
