import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:emotion_diary_app/provider/provider.dart';

class AuthProvider extends Provider {
  // 로그인 메서드
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final loginData = {'email': email, 'password': password};

      final response = await post(
        '/auth/login',
        loginData,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // 성공적인 응답
        return {
          'success': true,
          'message': response.body["access_token"],
        };
      } else {
        // 실패 응답 처리
        return {
          'success': false,
          'message': response.body["message"],
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

/*
  // 회원가입 메서드
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
    File? profileImage,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${httpClient.baseUrl}/auth/register'),
      );

      // 서버가 기대하는 형식으로 데이터 구조화
      final registerData = {
        'email': email,
        'password': password,
        'name': name,
      };

      if (profileImage != null) {
        final mimeType = _getMimeType(profileImage.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'profileImage',
            profileImage.path,
            contentType: MediaType(mimeType['type']!, mimeType['subtype']!),
          ),
        );
      }

      // 서버로 POST 요청
      final response = await post(
        '/auth/register',
        registerData, // JSON 형태의 사용자 데이터
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // 성공 상태 코드 확인
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "message": response.body['message']};
      } else {
        return {"success": false, "message": response.body['message']};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  Map<String, String> _getMimeType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
        return {'type': 'image', 'subtype': 'jpg'};
      case 'jpeg':
        return {'type': 'image', 'subtype': 'jpeg'};
      case 'png':
        return {'type': 'image', 'subtype': 'png'};
      case 'gif':
        return {'type': 'image', 'subtype': 'gif'};
      case 'webp':
        return {'type': 'image', 'subtype': 'webp'};
      default:
        return {'type': 'application', 'subtype': 'octet-stream'}; // 기본값
    }
  }
}
*/

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
    File? profileImage,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${httpClient.baseUrl}/auth/register'),
      );

      // JSON 데이터를 fields에 추가
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;

      // 프로필 이미지 추가
      if (profileImage != null) {
        final mimeType = _getMimeType(profileImage.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'profileImage',
            profileImage.path,
            contentType: MediaType(mimeType['type']!, mimeType['subtype']!),
          ),
        );
      }

      // 요청 보내기
      final streamedResponse = await request.send();

      // 응답 처리
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "message": response.body};
      } else {
        return {
          "success": false,
          "message": "서버 오류: ${response.statusCode}, ${response.body}"
        };
      }
    } catch (e) {
      return {"success": false, "message": "예외 발생: $e"};
    }
  }

// MIME 타입 계산 함수
  Map<String, String> _getMimeType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
        return {'type': 'image', 'subtype': 'jpg'};
      case 'jpeg':
        return {'type': 'image', 'subtype': 'jpeg'};
      case 'png':
        return {'type': 'image', 'subtype': 'png'};
      case 'gif':
        return {'type': 'image', 'subtype': 'gif'};
      case 'webp':
        return {'type': 'image', 'subtype': 'webp'};
      default:
        return {'type': 'application', 'subtype': 'octet-stream'}; // 기본값
    }
  }
}
