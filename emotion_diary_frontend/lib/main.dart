import 'package:emotion_diary_app/view/auth_index.dart';
import 'package:emotion_diary_app/view/home_screen.dart';
import 'package:emotion_diary_app/view/register_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  runApp(const MoodLogApp());
}

class MoodLogApp extends StatelessWidget {
  const MoodLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOODLOG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8CA8AC),
          elevation: 0,
        ),
      ),
      initialRoute: '/auth', // 첫 번째 화면 설정

      getPages: [
        GetPage(
          name: '/auth',
          page: () => const AuthIndex(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterForm(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}
