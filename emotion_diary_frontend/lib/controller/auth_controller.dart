import 'dart:io';
import 'package:get/get.dart';
import '../provider/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController extends GetxController {
  final AuthProvider _authProvider = Get.put(AuthProvider());
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await _authProvider.login(email, password);
    print("response");
    print(response);
    if (response['success']) {
      final token = response['message'];
      print("token:::::${token}");
      if (token != null) {
        await _storage.write(key: 'jwt_token', value: token); // JWT 저장
        print('JWT Token saved successfully');

        return true;
      } else {
        Get.snackbar('로그인 에러', 'JWT 토큰이 없습니다.',
            snackPosition: SnackPosition.BOTTOM);
      }
      return true;
    }
    Get.snackbar('로그인 에러', response['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<bool> register(
    String email,
    String password,
    String name,
    File? profileImage,
  ) async {
    final response =
        await _authProvider.register(email, password, name, profileImage);
    if (response["success"]) {
      return true; // 회원가입 성공
    } else {
      print('Registration failed: ${response['message']}');
      Get.snackbar(
        '회원가입 실패',
        '${response['message']}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
