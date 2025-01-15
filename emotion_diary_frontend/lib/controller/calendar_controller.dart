import 'package:get/get.dart';

class CalendarController extends GetxController {
  var currentMonth = DateTime.now().obs;

  void changeMonth(int offset) {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + offset,
    );
  }
}
