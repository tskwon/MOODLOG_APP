import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider {
  final String baseUrl = 'https://your-api-base-url.com'; // API 베이스 URL

  // 로그인 메서드
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'), // URL 구성
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // 성공적인 응답
        return jsonDecode(response.body);
      } else {
        // 실패 응답 처리
        return {
          'success': false,
          'message': '로그인에 실패했습니다. 상태 코드: ${response.statusCode}',
        };
      }
    } catch (e) {
      // 네트워크 에러 처리
      return {
        'success': false,
        'message': '네트워크 에러: $e',
      };
    }
  }

  // 회원가입 메서드
  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'), // URL 구성
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
        }),
      );

      if (response.statusCode == 201) {
        // 성공적으로 회원가입 완료
        return true;
      } else {
        // 실패 응답 처리
        print('회원가입 실패: 상태 코드 ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // 네트워크 에러 처리
      print('회원가입 중 네트워크 에러 발생: $e');
      return false;
    }
  }
}
