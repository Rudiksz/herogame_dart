extension Utils on DateTime {
  bool isSameDay(DateTime date) =>
      this.year == date?.year &&
      this.month == date?.month &&
      this.day == date?.day;
}
