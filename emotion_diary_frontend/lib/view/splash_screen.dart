import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3초 후 메인 화면으로 이동
    Future.delayed(const Duration(seconds: 3), () {
      //Get.offNamed('/diary'); // 로그인 화면으로 이동
      Get.offNamed('/login');
    });

    return Scaffold(
      backgroundColor: const Color(0xFF8CA8AC), // 청록색 배경색
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 감정 이미지들을 원형 배치
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/joy.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 85,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/sad.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 85,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/mad.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    left: 70,
                    bottom: 55,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/unrest.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    right: 70,
                    bottom: 55,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/unhappy.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            // 중앙 텍스트
            const Positioned(
              bottom: 20,
              child: Text(
                'Welcome to MOODLOG',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF8CF1A), // 노란색 텍스트
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
