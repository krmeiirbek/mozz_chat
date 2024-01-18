class THelperFunctions {
  static String getFormattedDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inHours < 1) {
      int minutes = difference.inMinutes;
      return '${minutes == 1 ? 'минут' : '$minutes минуты'} назад';
    } else if (dateTime.day == now.day) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (dateTime.day == now.day - 1) {
      return 'Вчера';
    } else if (dateTime.year == now.year) {
      return '${dateTime.day}.${dateTime.month.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}';
    }
  }

  static String getFormattedDay(DateTime dateTime) {
    DateTime now = DateTime.now();

    if (dateTime.day == now.day) {
      return 'Сегодня';
    } else if (dateTime.day == now.day - 1) {
      return 'Вчера';
    } else {
      return '${dateTime.day}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}';
    }
  }

  static String getFormattedTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
