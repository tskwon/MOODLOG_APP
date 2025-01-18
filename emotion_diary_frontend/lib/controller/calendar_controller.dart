import 'package:emotion_diary_app/provider/calendar_provider.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // 초기 상태 로드
    getMonthDiary(DateTime.now().year, DateTime.now().month);
  }

  final provider = Get.put(CalendarProvider()); // CalendarProvider 인스턴스 생성

  final moodData = <String, String>{}.obs; // 날짜와 감정 데이터를 저장하는 Observable 맵

  /// 월별 데이터를 가져오는 메서드
  Future<void> getMonthDiary(int year, int month) async {
    try {
      // 서버로부터 월별 데이터를 가져옴
      final response = await provider.getMonthlyDiaries(year, month);

      if (response['success'] == true) {
        // 성공적으로 데이터를 가져온 경우
        final List<dynamic> diaries = response['diaries'];
        // moodData 맵 초기화
        moodData.clear();

        // 가져온 데이터를 moodData에 저장
        for (var diary in diaries) {
          var day = diary['date'].split('-')[2];

          day = day[0] == '0' ? day[1] : day;

          moodData[day] = diary['emotion'];
        }
      } else {
        // 서버 응답에 실패한 경우
        print('Failed to fetch data: ${response['message']}');
      }
    } catch (e) {
      // 네트워크 에러 또는 기타 예외 처리
      print('Error fetching month diary: $e');
    }
    update();
  }
}
