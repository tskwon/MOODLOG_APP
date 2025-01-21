import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthProvider {
  //final String baseUrl = 'https://your-api-base-url.com'; // API 베이스 URL
  final String baseUrl = 'http://localhost:3720';
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

/*
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
  }*/
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    //required File profileImage,
    File? profileImage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/auth/register'),
      );

      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;
      /*
        request.files.add(
        await http.MultipartFile.fromPath(
          'profile_image',
          profileImage.path,
        ),
      );*/
      //test
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

      final response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        print('회원가입 실패: 상태 코드 ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('회원가입 중 네트워크 에러 발생: $e');
      return false;
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
