import 'package:emotion_diary_app/provider/provider.dart';

class CalendarProvider extends Provider {
  /// 서버에서 월별 데이터를 가져오는 메서드
  Future<Map<String, dynamic>> getMonthlyDiaries(int year, int month) async {
    try {
      // API 요청 경로 설정
      final url = '/calendar?year=$year&month=$month';

      // 서버에 GET 요청
      final response = await get(url);

      // 상태 코드 확인
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return {
          'success': false,
          'message':
              'Failed to fetch diaries. Status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching diaries: $e',
      };
    }
  }
}
