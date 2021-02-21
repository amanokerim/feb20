class MyTime {
  String toDdMmYyyy(DateTime t) {
    if (t == null) return "Не выбрано";
    return zerofy(t.day) + "." + zerofy(t.month) + "." + t.year.toString();
  }

  String zerofy(int n) {
    if (n < 10)
      return "0$n";
    else
      return "$n";
  }
}
