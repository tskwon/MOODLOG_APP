import 'package:emotion_diary_app/controller/calendar_controller.dart';
import 'package:emotion_diary_app/controller/emotion_controller.dart';
import 'package:emotion_diary_app/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarController calendarController = Get.find<CalendarController>();
  final EmotionController emotionController = Get.find<EmotionController>();

  CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = now.day;
    final year = now.year;
    final month = now.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startDayOfWeek = DateTime(year, month, 1).weekday + 1;
    final double boxSize = 33;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: SizedBox(
          // height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: daysInMonth + startDayOfWeek - 1,
        itemBuilder: (context, index) {
          // 빈칸 처리
          if (index < startDayOfWeek - 1) {
            return const SizedBox.shrink();
          }

          // 날짜 계산
          final day = (index - startDayOfWeek + 2).toString();
          // 감정 이미지 가져오기
          final emotionImage = calendarController.moodData[day];
          return GestureDetector(
            onTap: () async {
              if (int.parse(day) > today) {
                return;
              }
              // 선택된 날짜를 EmotionController에 설정
              emotionController.date.value =
                  DateTime(year, month, int.parse(day));

              // 해당 날짜의 일기 데이터 가져오기
              await emotionController.getDiary();

              // 홈 화면으로 이동
              Get.to(
                () => const HomeScreen(),
                transition: Transition.fadeIn,
              );
            },
            child: Container(
              width: boxSize,
              height: boxSize,
              alignment: Alignment.center,
              decoration: emotionImage == null
                  ? BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    )
                  : null,
              child: emotionImage != null
                  ? Image.asset(emotionImage, fit: BoxFit.contain)
                  : Text(
                      day,
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          );
        },
      )),
    );
  }
}
