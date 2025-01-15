import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../widgets/btn/label_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();

  // 회원가입 요청 처리
  Future<void> _submit() async {
    if (_passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordConfirmController.text.isEmpty) {
      Get.snackbar(
        'Error',
        '모든 필드를 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_passwordController.text != _passwordConfirmController.text) {
      Get.snackbar(
        'Error',
        '비밀번호가 일치하지 않습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    bool result = await authController.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
    );

    if (result) {
      Get.snackbar(
        'Success',
        '회원가입이 완료되었습니다!',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home'); // 회원가입 완료 후 홈 화면으로 이동
    } else {
      Get.snackbar(
        'Error',
        '회원가입에 실패했습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8CF1A), // 밝은 노란색
          ),
        ),
        backgroundColor: const Color(0xFF8CA8AC),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: screenWidth * 0.1,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey.shade700,
                size: screenWidth * 0.08,
              ),
            ),
            const SizedBox(height: 20),
            LabelTextField(
              label: '이름',
              hintText: '이름을 입력해주세요.',
              controller: _nameController,
              height: 50,
              keyboardType: TextInputType.name,
              isObscure: false,
            ),
            LabelTextField(
              label: '이메일',
              hintText: '이메일을 입력해주세요.',
              controller: _emailController,
              height: 50,
              keyboardType: TextInputType.emailAddress,
              isObscure: false,
            ),
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요.',
              controller: _passwordController,
              height: 50,
              keyboardType: TextInputType.visiblePassword,
              isObscure: true,
            ),
            LabelTextField(
              label: '비밀번호 확인',
              hintText: '비밀번호를 한번 더 입력해주세요.',
              controller: _passwordConfirmController,
              height: 50,
              keyboardType: TextInputType.visiblePassword,
              isObscure: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8CA8AC),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: _submit,
              child: const Text('회원가입', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
