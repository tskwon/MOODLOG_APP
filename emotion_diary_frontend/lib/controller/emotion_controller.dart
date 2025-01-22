import 'package:emotion_diary_app/provider/emotion_provider.dart';
import 'package:get/get.dart';

class EmotionController extends GetxController {
  final provider = Get.put(EmotionProvider());

  var name = ''.obs;
  var emotion = ''.obs;
  var text = ''.obs;
  var date = DateTime.now().obs;
  var isSaved = false.obs;
  var modify = false.obs;

  Future<void> saveDiary() async {
    try {
      final result = await provider.postDiary(
        name.value,
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
        name.value,
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

  // final Calendarcontroller = Get.find<CalendarController>();
  // 감정 분석 결과를 반환하는 메서드
  String analyzeEmotion() {
    // print("----");

    // print(Calendarcontroller.moodData);

    // List<String> emotions = Calendarcontroller.moodData.values.map((path) {
    //   // '/와 .jpg 사이의 문자열 추출
    //   String filename = path.split("/").last; // 마지막 파일명 추출
    //   return filename.split(".jpg")[0]; // .jpg 이전 부분 추출
    // }).toList();
    // print(emotions);

    return "ang";
  }
}
