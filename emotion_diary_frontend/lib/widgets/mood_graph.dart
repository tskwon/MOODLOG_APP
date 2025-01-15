import 'package:flutter/material.dart';
import 'dart:math';

class MoodGraph extends StatelessWidget {
  const MoodGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final double chartHeight = MediaQuery.of(context).size.height * 0.4;
    final List<double> emotionCenters = List.generate(
      5,
      (index) => chartHeight / 6 * (index + 1),
    );

    final List<double> dataPoints = List.generate(
      20,
      (_) => emotionCenters[Random().nextInt(emotionCenters.length)],
    );

    final List<Map<String, String>> emotions = [
      {'label': '기쁨', 'path': 'images/joy.jpg'},
      {'label': '화남', 'path': 'images/mad.jpg'},
      {'label': '슬픔', 'path': 'images/sad.jpg'},
      {'label': '불행', 'path': 'images/unhappy.jpg'},
      {'label': '불안', 'path': 'images/unrest.jpg'},
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SizedBox(
            width: 60,
            child: Stack(
              children: emotions.asMap().entries.map((entry) {
                final index = entry.key;
                final emotion = entry.value;
                final double position = emotionCenters[index];

                return Positioned(
                  top: position - 20,
                  child: Image.asset(
                    emotion['path']!,
                    width: 40,
                    height: 40,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
      canvas.drawLine(Offset(0, center), Offset(size.width, center), axisPaint);
    }

    final path = Path();
    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * stepX;
      final y = dataPoints[i];

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
