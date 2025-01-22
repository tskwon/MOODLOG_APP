import 'package:emotion_diary_app/shared/global.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// API 요청을 처리하는 기본 Provider 클래스
class Provider extends GetConnect {
  final _storage = FlutterSecureStorage();
  @override
  void onInit() {
    // 자체 서명된 인증서 허용
    allowAutoSignedCert = true;

    // API 서버 기본 URL 설정
    httpClient.baseUrl = Global.baseUrl; // 공통 URL 설정

    // 모든 요청에 JSON 응답 형식 지정
    httpClient.addRequestModifier<void>((request) async {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      try {
        final token = await _storage.read(key: 'jwt_token');
        if (token != null) {
          request.headers['Authorization'] = 'Bearer ${token}';
        }
      } catch (e) {
        print('Error reading token: $e');
      }
      return request;
    });

    // 응답 처리
    httpClient.addResponseModifier((request, response) {
      if (response.status.isServerError) {
        throw 'Server error occurred';
      }
      return response;
    });
    super.onInit();
  }
}
