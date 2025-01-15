import 'package:emotion_diary_app/view/home_screen.dart';
import 'package:emotion_diary_app/widgets/calendar_widget.dart';
import 'package:emotion_diary_app/widgets/mood_graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/calendar_controller.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());

  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String currentMonth = DateFormat.MMMM('ko_KR').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CA8AC),
        elevation: 0,
        title: const Text(
          'MOODLOG',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8CF1A),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/logo.jpg', fit: BoxFit.contain),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF8CA8AC)),
            ),
            onPressed: () => Get.to(
              () => HomeScreen(),
              transition: Transition.fadeIn,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              currentMonth,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: CalendarWidget(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: MoodGraph(),
          ),
        ],
      ),
    );
  }
}
