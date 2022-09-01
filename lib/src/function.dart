import 'dart:async';
import 'package:flutter/material.dart';

///默认时长
const _defaultDuration = Duration(milliseconds: 380);

enum FunctionType {
  debounce,
  throttle,
}

typedef VoidFunction = void Function();

class FunctionUtils {
  // ignore: prefer_final_fields
  static Map<String, Timer> _wrappers = {};

  ///防抖
  /// 防抖是指触发事件后在 n 秒内函数只能执行一次，如果在 n 秒内又触发了事件，则会重新计算函数执行时间。
  /// 举一个现实中的例子：商场里的感应扶梯，当没人的时候为了节能会降低运行速度。
  /// 就是在检测到没人（触发事件）后 n 秒后触发减速（执行函数），
  /// 如果n秒内又有人（又触发事件），则不减速（不执行函数）并重新计时。
  /// 在开发中主要用于在一定时间内不触发特定动作时再触发回调函数。
  /// 比如输入框的自动搜索，当用户输入结束后再进行搜索。可以使用防抖避免用户每输入一个字符就进行一次搜索。
  ///
  static VoidFunction debounce(String sign, function,
      {Duration duration = _defaultDuration}) {
    return () {
      execute(sign, function,
          duration: duration, functionType: FunctionType.debounce);
    };
  }

  /// 节流
  /// 节流是指在连续触发事件时，
  /// 在 n 秒中只执行一次函数。它会稀释函数的执行频率。
  /// 和防抖不同的是它会立即执行，然后在之后的n秒内不再响应。
  /// 也就是规定了函数在单位事件内最多只能被触发一次。
  /// 现实中常用的一个节流方法就是排队时限流。
  ///
  static VoidFunction throttle(String sign, function,
      {Duration duration = _defaultDuration}) {
    return () {
      execute(sign, function,
          duration: duration, functionType: FunctionType.throttle);
    };
  }

  static void execute(String sign, function,
      {Duration duration = _defaultDuration,
      FunctionType functionType = FunctionType.debounce}) {
    switch (functionType) {
      case FunctionType.debounce:
        _wrappers[sign]?.cancel();
        break;
      case FunctionType.throttle:
        if (_wrappers.containsKey(sign)) {
          return;
        } else {
          function.call();
        }
        break;
    }

    _wrappers[sign] = Timer(
      duration,
      () {
        if (functionType == FunctionType.debounce) {
          function.call();
        }
        _wrappers[sign]?.cancel();
        _wrappers.remove(sign);
      },
    );
  }

  ///在state的dispose方法里移除Timer
  static void remove(String sign) {
    if (_wrappers.containsKey(sign)) {
      _wrappers[sign]?.cancel();
      _wrappers.remove(sign);
    }
  }

  ///移除所有Timer
  static void clear() {
    _wrappers.forEach((key, value) {
      remove(key);
    });
    _wrappers.clear();
  }

  static void removeState(String hashString) {
    _wrappers.removeWhere((key, value) => key.startsWith(hashString));
  }
}

///State扩展类
///每个State所有的防抖和节流都带有同样的前缀
///方便管理和统一释放资源
extension EventFilterExtension on State {
  stateFilter(String sign, Function function,
      {Duration duration = _defaultDuration,
      FunctionType functionType = FunctionType.debounce}) {
    FunctionUtils.execute("${hashCode.toString()}$sign", function,
        duration: duration, functionType: functionType);
  }

  clearStateFilter() {
    FunctionUtils.removeState(hashCode.toString());
  }
}
