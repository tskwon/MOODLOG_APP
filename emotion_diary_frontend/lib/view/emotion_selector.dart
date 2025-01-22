import 'package:emotion_diary_app/shared/global.dart';
import 'package:flutter/material.dart';
import '../controller/emotion_controller.dart';

void showEmotionSelector(BuildContext context, EmotionController controller) {
  final List<Map<String, String>> emotions = Global.emotions;
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('감정을 선택하세요'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: emotions.map((emotion) {
            return GestureDetector(
              onTap: () {
                controller.emotion.value = emotion['path']!;
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Image.asset(emotion['path']!, width: 50, height: 50),
                  const SizedBox(width: 10),
                  Text(emotion['label']!),
                ],
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}
