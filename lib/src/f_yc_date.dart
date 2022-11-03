class FYcDate {
  ///获取现在的时间戳
  static int nowTimestamp() {
    var nowTime = DateTime.now();
    return nowTime.millisecondsSinceEpoch;
  }

  ///获取今天的开始时间戳
  static int todayStartTimestamp() {
    var nowTime = DateTime.now();
    var day = DateTime(nowTime.year, nowTime.month, nowTime.day, 0, 0, 0);
    return day.millisecondsSinceEpoch;
  }

  ///获取今天的结束时间戳
  static int todayEndTimestamp() {
    var nowTime = DateTime.now();
    var day = DateTime(nowTime.year, nowTime.month, nowTime.day, 23, 59, 59);
    return day.millisecondsSinceEpoch;
  }

  ///获取昨天的开始时间戳
  static int yesterdayStartTimestamp() {
    var nowTime = DateTime.now();
    var yesterday = nowTime.add(const Duration(days: -1));
    var day = DateTime(yesterday.year, yesterday.month, yesterday.day, 0, 0, 0);
    return day.millisecondsSinceEpoch;
  }

  ///获取昨天的结束时间戳
  static int yesterdayEndTimestamp() {
    var nowTime = DateTime.now();
    var yesterday = nowTime.add(const Duration(days: -1));
    var day =
        DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59);
    return day.millisecondsSinceEpoch;
  }

  ///获取本周的开始时间戳
  static int weekStartTimestamp() {
    var nowTime = DateTime.now();
    var weekday = nowTime.weekday;
    var yesterday = nowTime.add(Duration(days: -(weekday - 1)));
    var day = DateTime(yesterday.year, yesterday.month, yesterday.day, 0, 0, 0);
    return day.millisecondsSinceEpoch;
  }

  ///获取本月的开始时间戳
  static int monthStartTimestamp() {
    var nowTime = DateTime.now();
    var day = DateTime(nowTime.year, nowTime.month, 1, 0, 0, 0);
    return day.millisecondsSinceEpoch;
  }

  /// get DateTime By DateStr.
  static DateTime? getDateTime(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  /// get DateMilliseconds By DateStr.
  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }
}
