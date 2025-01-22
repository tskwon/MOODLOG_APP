import 'package:emotion_diary_app/controller/emotion_controller.dart';
import 'package:emotion_diary_app/view/home_screen.dart';
import 'package:emotion_diary_app/widgets/calendar_widget.dart';
import 'package:emotion_diary_app/widgets/mood_graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String currentMonth = DateFormat.MMMM('ko_KR').format(now);
    final EmotionController controller = Get.find<EmotionController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CA8AC),
        elevation: 0,
        title: const Text(
          'MOODLOG',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8CF1A),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/logo.jpg', fit: BoxFit.contain),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF8CA8AC)),
            ),
            onPressed: () async {
              controller.date.value = now;
              await controller.getDiary();
              Get.to(
                () => HomeScreen(),
                transition: Transition.fadeIn,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 14.0, right: 16.0, bottom: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 1.5, // 테두리 두긴
                  ),
                  borderRadius: BorderRadius.circular(8), // 테두리 두충기
                  color: Colors.white // 감정 이미지 없을 때 배경색
                  ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 3.0),
                    child: Text(
                      currentMonth,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 113, 112, 112),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.w600, // Thin
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey, // 선 색상
                    thickness: 2.0, // 선 두긴
                    indent: 20.0, // 외방 여배
                    endIndent: 20.0, // 오른외방 여배
                  ),
                  SizedBox(
                    height: 198,
                    width: 250,
                    child: CalendarWidget(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    "감정 분석 : ${controller.analyzeEmotion()}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 47, 46, 46),
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      fontWeight: FontWeight.w600, // Thin
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 1.5, // 테두리 두긴
                  ),
                  borderRadius: BorderRadius.circular(8), // 테두리 두충기
                  color: Colors.white // 감정 이미지 없을 때 배경색
                  ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 3.0),
                    child: Text(
                      "감정 그래프",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 113, 112, 112),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // Thin
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey, // 선 색상
                    thickness: 2.0, // 선 두긴
                    indent: 20.0, // 외방 여배
                    endIndent: 20.0, // 오른외방 여배
                  ),
                  SizedBox(
                    height: 190,
                    width: 280,
                    child: MoodGraph(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
