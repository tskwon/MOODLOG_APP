import 'package:emotion_diary_app/provider/emotion_provider.dart';
import 'package:get/get.dart';

class EmotionController extends GetxController {
  final provider = Get.put(EmotionProvider());

  // selectedEmotion -> emotion으로 변수명 변경 고려
  var emotion = ''.obs;
  var text = ''.obs;
  var date = DateTime.now().obs;
  var isSaved = false.obs;
  var modify = false.obs;

  Future<void> saveDiary() async {
    try {
      final result = await provider.postDiary(
        emotion.value,
        text.value,
        date.value,
      );
      isSaved.value = result ? true : false;
      // 결과 처리
    } catch (e) {
      print("Error saving diary: $e");
    }
    update();
  }

Future<void> putDiary() async {
    try {
      final result = await provider.putDiary(
        emotion.value,
        text.value,
        date.value,
      );
      isSaved.value = result ? true : false;
      // 결과 처리
    } catch (e) {
      print("Error saving diary: $e");
    }
    update();
  }

  Future<void> getDiary() async {
    try {
      print(date.value);
      final result = await provider.getDiary(date.value);
      if (result["success"] == true) {
        final diary = result['diaries'][0];
        emotion.value = diary['emotion'] ?? '';
        text.value = diary['text'] ?? '';
        modify.value = true;
      } else {
        emotion.value = '';
        text.value = '';
        modify.value = false;
      }
      // 결과 처리
    } catch (e) {
      print("Error saving diary: $e");
    }

    update();
  }
}
