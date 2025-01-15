import 'package:get/get.dart';

class EmotionController extends GetxController {
  var diaryText = ''.obs; // Text for the diary
  var selectedEmotion = ''.obs; // Path for selected emotion image
  var currentDate = DateTime.now().obs; // Current date
  var diarySaved = false.obs; // Flag for saved diary

  void selectEmotion(String emotion) {
    selectedEmotion.value = emotion;
  }

  void saveDiary(String text) {
    diaryText.value = text;
    diarySaved.value = true;
  }
}
