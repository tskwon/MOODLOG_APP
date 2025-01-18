import 'package:emotion_diary_app/model/emotion_model.dart';

import 'provider.dart';

class EmotionProvider extends Provider {
  Future<bool> postDiary(
      String selectedEmotion, String diaryText, DateTime currentDate) async {
    // 서버가 기대하는 형식으로 데이터 구조화
    final diaryData = Emotion(
      userId: 'user1', // 실제 사용자 ID로 교체 필요
      emotion: selectedEmotion, // selectedEmotion -> emotion
      text: diaryText, // diaryText -> text
      date: currentDate, // 이미 DateTime 객체이므로 toIso8601String() 호출 불필요
    ).toJson();

    try {
      final response = await post(
        '/diary',
        diaryData, // 변경된 데이터 구조 사용
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> putDiary(
      String selectedEmotion, String diaryText, DateTime currentDate) async {
    // 서버가 기대하는 형식으로 데이터 구조화
    final diaryData = Emotion(
      userId: 'user1', // 실제 사용자 ID로 교체 필요
      emotion: selectedEmotion, // selectedEmotion -> emotion
      text: diaryText, // diaryText -> text
      date: currentDate, // 이미 DateTime 객체이므로 toIso8601String() 호출 불필요
    ).toJson();
    print("put ---- ");
    print(diaryData);

    try {
      final response = await put(
        '/diary',
        diaryData, // 변경된 데이터 구조 사용
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getDiary(DateTime currentDate) async {
    // 서버가 기대하는 형식으로 데이터 구조화
    try {
      final res = await get(
        '/diary?year=${currentDate.year}&month=${currentDate.month}&day=${currentDate.day}',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch diaries. Status code: ${res.statusCode}'
        };
      }
    } catch (e) {
      return {"success": false, "message": e};
    }
  }
}
