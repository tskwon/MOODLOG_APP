import 'package:emotion_diary_app/controller/calendar_controller.dart';
import 'package:emotion_diary_app/controller/emotion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calendar_screen.dart';
import 'emotion_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmotionController controller = Get.find<EmotionController>();
    final CalendarController calendarController =
        Get.find<CalendarController>();

    final TextEditingController textController =
        TextEditingController(text: controller.text.value);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CA8AC), // 톤 다운된 청록색
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/logo.jpg', fit: BoxFit.contain),
        ),
        title: const Text(
          'MOODLOG',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8CF1A), // 밝은 노란색
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              Get.to(
                () => CalendarScreen(),
                transition: Transition.fadeIn,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.date.value.year}.${controller.date.value.month}.${controller.date.value.day}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => showEmotionSelector(context, controller),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: Obx(() => controller.emotion.value.isEmpty
                      ? const Center(
                          child: Text(
                            '이미지 없음',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            controller.emotion.value,
                            fit: BoxFit.cover,
                          ),
                        )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '일기 작성',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: textController,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: '오늘의 감정을 작성해보세요...',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          controller.text.value = textController.text;

          // 일기 저장 호출
          if (controller.modify.value) {
            await controller.putDiary();
          } else {
            await controller.saveDiary();
          }
          if (!context.mounted) return;

          // 성공 여부 처리
          if (controller.isSaved.value) {
            calendarController.getMonthDiary(
                controller.date.value.year, controller.date.value.month);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(const Duration(seconds: 2), () {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                });
                return controller.modify.value == true
                    ? const AlertDialog(
                        title: Text('수정 완료'),
                        content: Text('일기가 성공적으로 수정되었습니다!'),
                      )
                    : const AlertDialog(
                        title: Text('등록 완료'),
                        content: Text('일기가 성공적으로 등록되었습니다!'),
                      );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("일기 저장에 실패했습니다."),
              ),
            );
          }
        },
        label: controller.modify.value == true
            ? const Text('수정')
            : const Text('등록'),
        icon: const Icon(Icons.save),
        backgroundColor: const Color(0xFF8CA8AC),
      ),
    );
  }
}
