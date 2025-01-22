import 'package:emotion_diary_app/controller/emotion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../widgets/btn/label_textfield.dart';
import 'register_form.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  final authController = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final EmotionController emotionController = Get.find<EmotionController>();

  _submit() async {
    bool result = await authController.login(
      _emailController.text,
      _passwordController.text,
    );
    print(result);

    if (result) {
      Get.offAllNamed('/diary');
    } 
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CA8AC), // 톤 다운된 청록색
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/logo.jpg', fit: BoxFit.contain),
        ),
        title: const Text(
          'MOODLOG',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8CF1A), // 밝은 노란색
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8CA8AC),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: _submit,
              child: const Text('로그인', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => const RegisterForm());
              },
              child: const Text('회원가입',
                  style: TextStyle(color: Color(0xFF8CA8AC))),
            ),
          ],
        ),
      ),
    );
  }
}
