import 'package:emotion_diary_app/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoodGraph extends StatelessWidget {
  const MoodGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController =
        Get.find<CalendarController>();
    final double chartHeight = 180 ;

    final List<double> emotionCenters = List.generate(
      6,
      (index) => chartHeight / 6 * (index + 1) - 14,
    );

    final List<Map<String, String>> emotions = [
      {'label': '기쁨', 'path': 'images/joy.jpg'},
      {'label': '불안', 'path': 'images/unrest.jpg'},
      {'label': '슬픔', 'path': 'images/sad.jpg'},
      {'label': '불행', 'path': 'images/unhappy.jpg'},
      {'label': '화남', 'path': 'images/mad.jpg'},
    ];
    final List<double> dataPoints = calendarController.moodData.entries
        .map((entry) {
          final index = emotions.indexWhere((e) => e['path'] == entry.value);
          if (index != -1) {
            return emotionCenters[index]+18;
          } else {
            return null;
          }
        })
        .whereType<double>()
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: SizedBox(
            width: 60,
            child: Stack(
              children: emotions.asMap().entries.map((entry) {
                final index = entry.key;
                final emotion = entry.value;
                final double position = emotionCenters[index];

                return Positioned(
                  top: position ,
                  child: Image.asset(
                    emotion['path']!,
                    width: 28,
                    height: 28,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width * 0.8, chartHeight),
              painter: MoodGraphPainter(dataPoints, emotionCenters),
            ),
          ),
        ),
      ],
    );
  }
}

class MoodGraphPainter extends CustomPainter {
  final List<double> dataPoints;
  final List<double> emotionCenters;

  MoodGraphPainter(this.dataPoints, this.emotionCenters);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final axisPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.0;

    final double stepX = size.width / (dataPoints.length - 1);


    for (final center in emotionCenters) {
      canvas.drawLine(
          Offset(-54, center-1), Offset(size.width , center-1), axisPaint);
    }

    final path = Path();
    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * stepX - 12;
      final y = dataPoints[i];

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
