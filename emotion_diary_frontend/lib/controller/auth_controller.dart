import 'dart:io';
import 'package:get/get.dart';
import '../provider/auth_provider.dart';

class AuthController extends GetxController {
  final AuthProvider _authProvider = AuthProvider();

  Future<bool> login(String email, String password) async {
    Map body = await _authProvider.login(email, password);
    if (body['result'] == 'ok') {
      return true;
    }
    Get.snackbar('로그인 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

/*
  Future<bool> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      return await _authProvider.register(
        email: email,
        password: password,
        name: name,
      );
    } catch (e) {
      print('Error during registration: $e');
      Get.snackbar('회원가입 에러', '회원가입 중 문제가 발생했습니다.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
  */
  Future<bool> register(
    String email,
    String password,
    String name,
    File? profileImage, //nullable
  ) async {
    /*
    if (profileImage == null) {
      Get.snackbar(
        'Error',
        '프로필 사진을 선택해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }*/

    try {
      return await _authProvider.register(
        email: email,
        password: password,
        name: name,
        profileImage: profileImage,
      );
    } catch (e) {
      print('Error during registration: $e');
      Get.snackbar('회원가입 에러', '회원가입 중 문제가 발생했습니다.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}
